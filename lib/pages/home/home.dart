// Core
import 'package:flutter/material.dart';

// External
import 'package:go_router/go_router.dart';

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
  List<Widget> getItems(BuildContext context) {
    List<Widget> items = [];
    for (var i = 0; i < 4; i++) {
      items.add(
        TimeLineItem(
          title: "Lorem ipsum dolor sit amet consectetur adipiscing elit",
          description:
              "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.",
          year: "20xx",
          onOpen: () => context.go("/dummy"),
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
      body: Timeline(children: getItems(context)),
    );
  }
}
