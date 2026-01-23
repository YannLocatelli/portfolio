// Core
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';

// Portfolio
import 'package:portfolio/services/firebase.dart';
import 'package:portfolio/supports/router.dart';

void main() async {
  usePathUrlStrategy();

  await initializeFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Yann Locatelli | Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.orange),
        textTheme: GoogleFonts.figtreeTextTheme(),
      ),
    );
  }
}
