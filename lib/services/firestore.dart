// Core
import 'package:flutter/material.dart';

// External
import 'package:cloud_firestore/cloud_firestore.dart';

// Portfolio
import 'package:portfolio/supports/globals.dart' as globals;
import 'package:portfolio/models/project.dart';
import 'package:portfolio/models/section.dart';

class AdminDatabaseService {
  static final DocumentReference _adminMonitoring = FirebaseFirestore.instance
      .collection("admin")
      .doc("monitoring");

  static Future syncMonitoring() async {
    try {
      final data = await _adminMonitoring.get();
      globals.maintenanceEnabled = data["maintenance"] ?? true;
    } catch (exception) {
      debugPrint("$exception");
    }
  }
}

class ProjectDatabaseService {
  static final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection(Project.databaseName);

  static Future fetchProjectsCards() async {
    List<Project> projects = [];

    try {
      final data = await collection
          .where(Project.visibleField, isEqualTo: true)
          .orderBy(Project.orderField)
          .get();

      for (var projectDoc in data.docs) {
        projects.add(Project.fromDocument(projectDoc.id, projectDoc.data()));
      }

      return projects;
    } catch (exception) {
      debugPrint("$exception");
    }
  }

  static Future fetchProject(String id) async {
    try {
      final data = await collection.doc(id).get();
      final project = Project.fromDocument(data.id, data.data()!);
      project.sections = await fetchSections(project.id);
      return project;
    } catch (exception) {
      debugPrint("$exception");
    }
  }

  static Future fetchSections(String projectID) async {
    List<Section> sections = [];

    final subCollection = collection
        .doc(projectID)
        .collection(Section.databaseName);

    try {
      final data = await subCollection
          .where(Section.visibleField, isEqualTo: true)
          .orderBy(Section.orderField)
          .get();

      for (var sectionDoc in data.docs) {
        final sectionsData = sectionDoc.data();

        final type = sectionsData[Section.typeField];
        if (type == Mission.typeValue) {
          sections.add(Mission.fromDocument(sectionDoc.id, sectionsData));
        } else if (type == Gallery.typeValue) {
          sections.add(Gallery.fromDocument(sectionDoc.id, sectionsData));
        }
      }

      return sections;
    } catch (exception) {
      debugPrint("$exception");
      return [];
    }
  }
}
