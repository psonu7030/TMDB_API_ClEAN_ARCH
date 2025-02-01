class Recommendation {
  final int page;
  final List<Result> results;

  const Recommendation({
    required this.page,
    required this.results,
  });
}

class Result {
  final String? backdropPath;
  final int id;
  final String title;

  const Result({
    this.backdropPath,
    required this.id,
    required this.title,
  });
}
