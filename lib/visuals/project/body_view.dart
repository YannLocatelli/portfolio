// Core
import 'package:flutter/material.dart';

// Portfolio
import 'package:portfolio/models/section.dart';
import 'package:portfolio/visuals/project/mission_widget.dart';
import 'package:portfolio/visuals/project/gallery_widget.dart';

class BodyWidget extends StatelessWidget {
  final List<Section> sections;

  const BodyWidget({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const .fromLTRB(24, 0, 24, 32),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        if (sections[index].type == Mission.typeValue) {
          return Padding(
            padding: .symmetric(vertical: 8),
            child: MissionWidget(mission: sections[index] as Mission),
          );
        } else if (sections[index].type == Gallery.typeValue) {
          return Padding(
            padding: .symmetric(vertical: 8),
            child: GalleryWidget(gallery: sections[index] as Gallery),
          );
        }
        return Text("ERROR");
      },
    );
  }
}
