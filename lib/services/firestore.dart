// Core
import 'package:flutter/material.dart';

// External
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/models/project.dart';

// Portfolio
import 'package:portfolio/supports/globals.dart' as globals;

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
      FirebaseFirestore.instance.collection("project");

  static Future fetchProjectsCards() async {
    List<Project> projects = [];

    try {
      final data = await collection
          .where("visible", isEqualTo: true)
          .orderBy("order")
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
      return project;
    } catch (exception) {
      debugPrint("$exception");
    }
  }
}
