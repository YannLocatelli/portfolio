// Core
import 'package:flutter/material.dart';

// External
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';

// Portfolio
import 'package:portfolio/pages/dummy_page.dart';
import 'package:portfolio/pages/home/home.dart';
import 'package:portfolio/pages/project/project_page.dart';

final router = GoRouter(
  observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        final isBack = state.extra == 'back';

        return CustomTransitionPage(
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final begin = isBack ? const Offset(-1, 0) : const Offset(1, 0);
            const end = Offset.zero;

            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: Curves.ease)),
              ),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(path: '/dummy', builder: (context, state) => const DummyPage()),
    GoRoute(
      path: '/project/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProjectPage(id: id);
      },
    ),
  ],
);
