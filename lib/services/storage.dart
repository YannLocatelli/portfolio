// Core
import 'package:flutter/material.dart';

// External
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<String?> getMaintenanceFile() async {
    try {
      final ref = FirebaseStorage.instance.ref('maintenance.jpg');
      final url = await ref.getDownloadURL();
      return url;
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  static Future<String?> getFile(String name) async {
    try {
      final ref = FirebaseStorage.instance.ref(name);
      final url = await ref.getDownloadURL();
      return url;
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }
}
