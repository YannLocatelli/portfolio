// Core
import 'package:flutter/material.dart';

// External
import 'package:go_router/go_router.dart';

// Portfolio
import 'package:portfolio/supports/theme.dart';
import 'package:portfolio/visuals/maintenance.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dummy page", style: const TextStyle(color: Colors.white)),
        leading: BackButton(onPressed: () => context.go("/", extra: 'back')),
        backgroundColor: normalPrimary,
      ),
      body: MaintenanceWidget(),
    );
  }
}
