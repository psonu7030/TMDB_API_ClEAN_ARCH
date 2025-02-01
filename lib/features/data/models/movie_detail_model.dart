
import '../../domain/entities/movie_detail_entity.dart';

class MovieDetailModel {
  final bool adult;
  final String backdropPath;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String tagline;
  final String title;
  final double voteAverage;
  final int voteCount;
  final List<GenreModel> genres;

  MovieDetailModel({
    required this.adult,
    required this.backdropPath,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? "",
        homepage: json["homepage"] ?? "",
        id: json["id"],
        imdbId: json["imdb_id"] ?? "",
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? "",
        releaseDate: json["release_date"] ?? "",
        runtime: json["runtime"] ?? 0,
        tagline: json["tagline"] ?? "",
        title: json["title"],
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        genres: json["genres"] != null
            ? List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "runtime": runtime,
    "tagline": tagline,
    "title": title,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
  MovieDetail toEntity() {
    return MovieDetail(
      adult: adult,
      backdropPath: backdropPath,
      homepage: homepage,
      id: id,
      imdbId: imdbId,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      runtime: runtime,
      tagline: tagline,
      title: title,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
class GenreModel {
  final int id;
  final String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
