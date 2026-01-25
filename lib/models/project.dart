class Project {
  String id;
  bool? visible;

  String title;
  String description;
  String year;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
  });

  // Database fields
  static const String databaseName = 'project';

  static const String visibleField = 'visible';
  static const String titleField = 'title';
  static const String descriptionField = 'description';
  static const String yearField = 'year';

  factory Project.fromDocument(String id, Map<String, dynamic> doc) {
    return Project(
      id: id,
      title: doc[titleField] ?? "",
      description: doc[descriptionField] ?? "",
      year: doc[yearField] ?? "",
    );
  }
}
