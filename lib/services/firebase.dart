// Flutter Core
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// External
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

const firebaseWebOptions = FirebaseOptions(
  apiKey: "AIzaSyCnsntwBejQrK3K3jzp4MVN2itbR_semLE",
  authDomain: "portfolio-76903.firebaseapp.com",
  projectId: "portfolio-76903",
  storageBucket: "portfolio-76903.firebasestorage.app",
  messagingSenderId: "829840361104",
  appId: "1:829840361104:web:fa6bfea2f2c37356d8fa15",
  measurementId: "G-7MDQ5RBFJ3",
);

Future initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(options: firebaseWebOptions);
  } else {
    await Firebase.initializeApp();
  }

  if (!kDebugMode) {
    await FirebaseAppCheck.instance.activate(
      providerWeb: ReCaptchaEnterpriseProvider(
        '6LdUSFMsAAAAAC5DWmrZK4HW8c8CLfIAiHkzIL-b',
      ),
    );
  }

  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
}
