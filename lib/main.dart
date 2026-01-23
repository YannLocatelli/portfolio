// Core
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// External
import 'package:portfolio/services/firebase.dart';
import 'package:portfolio/services/firestore.dart';

// Portfolio
import 'package:portfolio/supports/router.dart';

void main() async {
  usePathUrlStrategy();

  await initializeFirebase();
  await AdminDatabaseService.syncMonitoring();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Yann Locatelli',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.orange),
      ),
    );
  }
}
