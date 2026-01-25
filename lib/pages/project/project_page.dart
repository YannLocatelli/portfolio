// Core
import 'package:flutter/material.dart';

// External
import 'package:go_router/go_router.dart';

// Portfolio
import 'package:portfolio/supports/theme.dart';
import 'package:portfolio/visuals/maintenance.dart';
import 'package:portfolio/services/firestore.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/services/storage.dart';
import 'package:portfolio/pages/project/header.dart';
import 'package:portfolio/pages/project/body.dart';

class ProjectPage extends StatefulWidget {
  final String id;

  const ProjectPage({super.key, required this.id});

  @override
  State<ProjectPage> createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage> {
  bool isLoading = true;

  Project? project;
  String illustrationURL =
      "https://firebasestorage.googleapis.com/v0/b/portfolio-76903.firebasestorage.app/o/test.jpg?alt=media&token=dc279022-c36d-48b0-969e-86dd144d1bbf";

  @override
  void initState() {
    super.initState();

    syncDatabase();
  }

  void syncDatabase() async {
    project = await ProjectDatabaseService.fetchProject(widget.id);
    if (project == null) return;
    final url = await FirebaseStorageService.getFile(project!.illustrationName);

    setState(() {
      if (url != null) illustrationURL = url;
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
    return Column(
      children: [
        HeaderWidget(project: project!),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: body(),
          ),
        ),
      ],
    );
  }

  Widget body() {
    if (project!.missions.isEmpty) {
      return MaintenanceWidget();
    }
    return BodyWidget(project: project!);
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
