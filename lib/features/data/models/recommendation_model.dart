import 'dart:convert';

import '../../domain/entities/recommendation.dart';

RecommendationModel recommendationModelFromJson(String str) =>
    RecommendationModel.fromJson(json.decode(str));

String recommendationModelToJson(RecommendationModel data) =>
    json.encode(data.toJson());

class RecommendationModel {
  int page;
  List<ResultModel> results;

  RecommendationModel({
    required this.page,
    required this.results,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      RecommendationModel(
        page: json["page"],
        results: List<ResultModel>.from(
            json["results"].map((x) => ResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };

  Recommendation toEntity() {
    return Recommendation(
      page: page,
      results: results.map((result) => result.toEntity()).toList(),
    );
  }
}

class ResultModel {
  String? backdropPath;
  int id;
  String title;

  ResultModel({
    this.backdropPath,
    required this.id,
    required this.title,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
    backdropPath: json["backdrop_path"] != null
        ? json["backdrop_path"]
        : null,
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
  };

  Result toEntity() {
    return Result(
      backdropPath: backdropPath,
      id: id,
      title: title,
    );
  }
}
