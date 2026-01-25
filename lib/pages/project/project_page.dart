// Core
import 'package:flutter/material.dart';

// External
import 'package:go_router/go_router.dart';
import 'package:portfolio/models/project.dart';

// Portfolio
import 'package:portfolio/supports/theme.dart';
import 'package:portfolio/visuals/maintenance.dart';
import 'package:portfolio/services/firestore.dart';

class ProjectPage extends StatefulWidget {
  final String id;

  const ProjectPage({super.key, required this.id});

  @override
  State<ProjectPage> createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage> {
  bool isLoading = true;

  Project? project;

  @override
  void initState() {
    super.initState();

    syncDatabase();
  }

  void syncDatabase() async {
    project = await ProjectDatabaseService.fetchProject(widget.id);

    setState(() {
      isLoading = false;
    });
  }

  Widget loading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget missing() {
    return MaintenanceWidget(message: "Ce projet n'existe pas");
  }

  Widget content() {
    return MaintenanceWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          project != null
              ? "Yann Locatelli | ${project?.title}"
              : "Yann Locatelli",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () => context.go("/", extra: 'back'),
          color: Colors.white,
        ),
        backgroundColor: normalPrimary,
      ),
      body: isLoading
          ? loading()
          : project != null
          ? content()
          : missing(),
    );
  }
}
