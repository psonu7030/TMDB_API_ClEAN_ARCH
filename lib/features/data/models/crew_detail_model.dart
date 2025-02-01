import 'dart:convert';
import '../../domain/entities/crew_detail.dart';

CrewDetailModel crewDetailModelFromJson(String str) => CrewDetailModel.fromJson(json.decode(str));

String crewDetailModelToJson(CrewDetailModel data) => json.encode(data.toJson());

class CrewDetailModel {
  int id;
  List<CastModel> crew;

  CrewDetailModel({
    required this.id,
    required this.crew,
  });

  factory CrewDetailModel.fromJson(Map<String, dynamic> json) => CrewDetailModel(
    id: json["id"],
    crew: List<CastModel>.from(json["crew"].map((x) => CastModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
  };
  CrewDetail toEntity() {
    return CrewDetail(
      id: id,
      crew: crew.map((cast) => cast.toEntity()).toList(),
    );
  }
}

class CastModel {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;

  CastModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
  };

  Cast toEntity() {
    return Cast(
      adult: adult,
      gender: gender,
      id: id,
      knownForDepartment: knownForDepartment,
      name: name,
      originalName: originalName,
    );
  }
}
