class Section {
  String id;
  String type;

  Section({required this.id, required this.type});

  // Database fields
  static const String databaseName = 'sections';

  static const String visibleField = 'visible';
  static const String orderField = 'order';
  static const String typeField = 'type';

  factory Section.fromDocument(String id, Map<String, dynamic> doc) {
    return Section(id: id, type: doc[typeField] ?? "");
  }
}

class Mission extends Section {
  String title;
  List<String> text;
  String? illustrationName;
  List? tags;
  Map? linkButtons;

  Mission({
    required super.id,
    required super.type,
    required this.title,
    required this.text,
    this.illustrationName,
    this.tags,
    this.linkButtons,
  });

  // Database fields
  static const String typeValue = 'mission';

  static const String titleField = 'title';
  static const String textField = 'text';
  static const String illustrationNameField = 'illustrationName';
  static const String tagsField = 'tags';
  static const String linkButtonsField = 'linkButtons';

  factory Mission.fromDocument(String id, Map<String, dynamic> doc) {
    List<String> text = [];
    if (doc[textField] != null) {
      for (String e in doc[textField]) {
        text.add(e);
      }
    }

    return Mission(
      id: id,
      type: doc[Section.typeField] ?? typeValue,
      title: doc[titleField] ?? "",
      text: text,
      illustrationName: doc[illustrationNameField],
      tags: doc[tagsField],
      linkButtons: doc[linkButtonsField],
    );
  }
}

class Gallery extends Section {
  List<String>? illustrationsName;

  Gallery({required super.id, required super.type, this.illustrationsName});

  // Database fields
  static const String typeValue = 'gallery';

  static const String illustrationsNameField = 'illustrationsName';

  factory Gallery.fromDocument(String id, Map<String, dynamic> doc) {
    List<String> illustrationsName = [];
    if (doc[illustrationsNameField] != null) {
      for (String e in doc[illustrationsNameField]) {
        illustrationsName.add(e);
      }
    }

    return Gallery(
      id: id,
      type: doc[Section.typeField] ?? typeValue,
      illustrationsName: illustrationsName,
    );
  }
}
