// Core
import 'package:flutter/material.dart';

// External
import 'package:auto_size_text/auto_size_text.dart';

// Portfolio
import 'package:portfolio/models/project.dart';
import 'package:portfolio/services/storage.dart';

class HeaderWidget extends StatefulWidget {
  final Project project;

  const HeaderWidget({super.key, required this.project});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool isLoading = true;
  String illustrationURL =
      "https://firebasestorage.googleapis.com/v0/b/portfolio-76903.firebasestorage.app/o/test.jpg?alt=media&token=dc279022-c36d-48b0-969e-86dd144d1bbf";

  @override
  void initState() {
    super.initState();

    fetchIllustration();
  }

  void fetchIllustration() async {
    final url = await FirebaseStorageService.getFile(
      widget.project.illustrationName,
    );

    setState(() {
      if (url != null) illustrationURL = url;
      isLoading = false;
    });
  }

  Widget loading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget yearText(BuildContext context) {
    return AutoSizeText(
      widget.project.year,
      minFontSize: 14,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget titleText(BuildContext context) {
    return AutoSizeText(
      widget.project.title,
      maxLines: null,
      minFontSize: 17,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: .bold),
    );
  }

  Widget illustrationImage(BuildContext context) {
    final double size = 80;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF302A24), width: 1),
      ),
      child: ClipOval(
        child: Image.network(
          illustrationURL,
          fit: .cover,
          webHtmlElementStrategy: .prefer,
        ),
      ),
    );
  }

  Widget descriptionText(BuildContext context) {
    return AutoSizeText(
      widget.project.description,
      maxLines: null,
      minFontSize: 14,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget spacer({double height = 6}) {
    return SizedBox(height: height);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  flex: 100,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [titleText(context), spacer(), yearText(context)],
                  ),
                ),
                Spacer(),
                isLoading ? loading() : illustrationImage(context),
              ],
            ),
            spacer(height: 12),
            descriptionText(context),
          ],
        ),
      ),
    );
  }
}
