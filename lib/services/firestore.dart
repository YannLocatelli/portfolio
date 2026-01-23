// Core
import 'package:flutter/material.dart';

// External
import 'package:cloud_firestore/cloud_firestore.dart';

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
