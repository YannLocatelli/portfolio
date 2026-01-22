// Core
import 'package:flutter/material.dart';

// External
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<String?> getTestFile() async {
    try {
      final ref = FirebaseStorage.instance.ref('test.jpg');
      final url = await ref.getDownloadURL();
      return url;
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }
}
