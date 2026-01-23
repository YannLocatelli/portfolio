// Core
import 'package:firebase_analytics/firebase_analytics.dart';

// External
import 'package:go_router/go_router.dart';

// Portfolio
import 'package:portfolio/pages/about/about.dart';
import 'package:portfolio/pages/home/home.dart';

final router = GoRouter(
  observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/about', builder: (context, state) => const AboutPage()),
    // GoRoute(
    //   path: '/project/:id',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return ProjectPage(id: id);
    //   },
    // ),
  ],
);
