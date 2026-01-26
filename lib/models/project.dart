import 'package:portfolio/models/section.dart';

class Project {
  String id;
  bool? visible;

  String title;
  String description;
  String year;
  String illustrationName;

  List<Section> sections = [];

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
    required this.illustrationName,
  });

  // Database fields
  static const String databaseName = 'project';

  static const String visibleField = 'visible';
  static const String orderField = 'order';
  static const String titleField = 'title';
  static const String descriptionField = 'description';
  static const String yearField = 'year';
  static const String illustrationNameField = 'illustrationName';

  factory Project.fromDocument(String id, Map<String, dynamic> doc) {
    return Project(
      id: id,
      title: doc[titleField] ?? "",
      description: doc[descriptionField] ?? "",
      year: doc[yearField] ?? "",
      illustrationName: doc[illustrationNameField] ?? "test.jpg",
    );
  }
}
