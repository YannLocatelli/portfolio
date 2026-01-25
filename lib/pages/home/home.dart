// Core
import 'package:flutter/material.dart';

// External
import 'package:go_router/go_router.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/services/firestore.dart';

// Portfolio
import 'package:portfolio/supports/theme.dart';
import 'package:portfolio/pages/home/timeline.dart';
import 'package:portfolio/pages/home/timeline_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Project> projects = [];

  @override
  void initState() {
    super.initState();

    syncDatabase();
  }

  void syncDatabase() async {
    projects = await ProjectDatabaseService.fetchProjectsCards();

    setState(() {
      isLoading = false;
    });
  }

  Widget loading() {
    return Center(child: CircularProgressIndicator());
  }

  List<Widget> buildItems(BuildContext context) {
    List<Widget> items = [];

    for (var p in projects) {
      items.add(
        TimeLineItem(
          title: p.title,
          description: p.description,
          year: p.year,
          onOpen: () => context.go("/project/${p.id}"),
        ),
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: normalPrimary,
        title: Text(
          "Yann Locatelli",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading ? loading() : Timeline(children: buildItems(context)),
    );
  }
}
