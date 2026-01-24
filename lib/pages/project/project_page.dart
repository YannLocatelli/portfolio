// Core
import 'package:flutter/material.dart';

// External
import 'package:go_router/go_router.dart';

// Portfolio
import 'package:portfolio/supports/theme.dart';
import 'package:portfolio/visuals/maintenance.dart';

class ProjectPage extends StatefulWidget {
  final String id;

  const ProjectPage({super.key, required this.id});

  @override
  State<ProjectPage> createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yann Locatelli | ${widget.id}",
          style: const TextStyle(color: Colors.white),
        ),
        leading: BackButton(onPressed: () => context.go("/", extra: 'back')),
        backgroundColor: normalPrimary,
      ),
      body: MaintenanceWidget(),
    );
  }
}
