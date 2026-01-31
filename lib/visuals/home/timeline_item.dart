// Core
import 'package:flutter/material.dart';

// External
import 'package:auto_size_text/auto_size_text.dart';

// Portfolio
import 'package:portfolio/services/storage.dart';

class TimeLineItem extends StatefulWidget {
  final String title;
  final String description;
  final String year;
  final String illustrationName;
  final VoidCallback onOpen;

  const TimeLineItem({
    super.key,

    required this.title,
    required this.description,
    required this.year,
    required this.illustrationName,
    required this.onOpen,
  });

  @override
  State<TimeLineItem> createState() => _TimeLineItemState();
}

class _TimeLineItemState extends State<TimeLineItem> {
  bool isLoading = true;
  String illustrationURL =
      "https://firebasestorage.googleapis.com/v0/b/portfolio-76903.firebasestorage.app/o/default.png?alt=media&token=46bb01df-ff8b-44c7-9186-685c0f4d81b7";

  @override
  void initState() {
    super.initState();

    fetchIllustration();
  }

  void fetchIllustration() async {
    final url = await FirebaseStorageService.getFile(widget.illustrationName);

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
      widget.year,
      minFontSize: 14,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  Widget titleText(BuildContext context) {
    return AutoSizeText(
      widget.title,
      maxLines: 1,
      minFontSize: 17,
      overflow: .ellipsis,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: .bold),
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
      widget.description,
      maxLines: 7,
      minFontSize: 14,
      overflow: .ellipsis,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget goFurtherButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        onPressed: widget.onOpen,
        label: const Text('Voir plus'),
        icon: const Icon(Icons.arrow_forward),
        iconAlignment: .end,
      ),
    );
  }

  Widget spacer({double height = 6}) {
    return SizedBox(height: height);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
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

            spacer(height: 2),
            Divider(),
            spacer(),
            descriptionText(context),
            spacer(height: 12),
            goFurtherButton(context),
          ],
        ),
      ),
    );
  }
}
