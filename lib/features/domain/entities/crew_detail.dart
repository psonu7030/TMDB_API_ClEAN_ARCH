class CrewDetail {
  final int id;
  final List<Cast> crew;
  const CrewDetail({
    required this.id,
    required this.crew,
  });
}
class Cast {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;

  const Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
  });
}
