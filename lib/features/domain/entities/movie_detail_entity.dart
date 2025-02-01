class MovieDetail {
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

  const MovieDetail({
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
  });
}

