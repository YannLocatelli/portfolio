// Core
import 'package:flutter/material.dart';

// External
import 'package:auto_size_text/auto_size_text.dart';

class TimeLineItem extends StatelessWidget {
  final String title;
  final String description;
  final String year;
  final VoidCallback onOpen;

  const TimeLineItem({
    super.key,
    required this.title,
    required this.description,
    required this.year,
    required this.onOpen,
  });

  Widget yearText(BuildContext context) {
    return AutoSizeText(
      year,
      minFontSize: 14,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  Widget titleText(BuildContext context) {
    return AutoSizeText(
      title,
      maxLines: 1,
      minFontSize: 17,
      overflow: .ellipsis,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: .bold),
    );
  }

  Widget descriptionText(BuildContext context) {
    return AutoSizeText(
      description,
      maxLines: 3,
      minFontSize: 14,
      overflow: .ellipsis,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget goFurtherButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        onPressed: onOpen,
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
            titleText(context),
            spacer(),
            yearText(context),
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
