// Core
import 'package:flutter/material.dart';

// Portfolio
import 'package:portfolio/models/project.dart';

class BodyWidget extends StatefulWidget {
  final Project project;

  const BodyWidget({super.key, required this.project});

  @override
  State<BodyWidget> createState() => BodyWidgetState();
}

class BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
