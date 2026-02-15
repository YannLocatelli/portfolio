// Core
import 'package:flutter/material.dart';

// External
import 'package:go_router/go_router.dart';

// Portfolio
import 'package:portfolio/models/project.dart';
import 'package:portfolio/supports/theme.dart';
import 'package:portfolio/services/firestore.dart';
import 'package:portfolio/services/storage.dart';
import 'package:portfolio/visuals/maintenance_widget.dart';
import 'package:portfolio/visuals/project/header_view.dart';
import 'package:portfolio/visuals/project/body_view.dart';

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
      "https://firebasestorage.googleapis.com/v0/b/portfolio-76903.firebasestorage.app/o/default.png?alt=media&token=46bb01df-ff8b-44c7-9186-685c0f4d81b7";

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
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: HeaderWidget(project: project!),
        ),

        Expanded(child: body()),
      ],
    );
  }

  Widget body() {
    if (project!.sections.isEmpty) {
      return MaintenanceWidget();
    }
    return BodyWidget(sections: project!.sections);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          project != null
              ? "Yann Locatelli | ${project?.title.split(':').first.trim()}"
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
