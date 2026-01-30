// Core
import 'package:flutter/material.dart';

// External
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

// Portfolio
import 'package:portfolio/models/section.dart';
import 'package:portfolio/services/storage.dart';
import 'package:portfolio/supports/theme.dart';

class MissionWidget extends StatefulWidget {
  final Mission mission;

  const MissionWidget({super.key, required this.mission});

  @override
  State<MissionWidget> createState() => MissionWidgetState();
}

class MissionWidgetState extends State<MissionWidget> {
  bool isLoading = true;
  String? illustrationURL;

  @override
  void initState() {
    super.initState();

    fetchIllustration();
  }

  void fetchIllustration() async {
    String? url;
    if (widget.mission.illustrationName != null) {
      url = await FirebaseStorageService.getFile(
        widget.mission.illustrationName!,
      );
    }

    setState(() {
      illustrationURL = url;
      isLoading = false;
    });
  }

  Widget loading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget spacer({double height = 6}) {
    return SizedBox(height: height);
  }

  Widget titleText(BuildContext context) {
    return AutoSizeText(
      widget.mission.title,
      maxLines: null,
      minFontSize: 20,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: .bold),
    );
  }

  Widget illustrationImage(BuildContext context, bool isLoading) {
    if (isLoading) {
      return loading();
    }

    if (illustrationURL == null) {
      return SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        shape: .rectangle,
        border: .all(color: const Color(0xFF302A24), width: 2),
      ),
      child: ClipRRect(
        child: Image.network(
          illustrationURL!,
          fit: .cover,
          webHtmlElementStrategy: .prefer,
        ),
      ),
    );
  }

  Widget descriptionText(BuildContext context) {
    if (widget.mission.text.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: .start,
      children: widget.mission.text
          .map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AutoSizeText(t),
            ),
          )
          .toList(),
    );
  }

  Widget tagsWidget(BuildContext context) {
    if (widget.mission.tags == null || widget.mission.tags!.isEmpty) {
      return SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      // alignment: .start,
      // crossAxisAlignment: .start,
      // runAlignment: .start,
      children: widget.mission.tags!
          .map(
            (t) => Chip(
              backgroundColor: normalPrimary,
              // padding: const EdgeInsets.only(bottom: 8),
              label: Text(t),
            ),
          )
          .toList(),
    );
  }

  Widget linkButtonsWidget(BuildContext context) {
    if (widget.mission.linkButtons == null ||
        widget.mission.linkButtons!.isEmpty) {
      return SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      // alignment: .start,
      // crossAxisAlignment: .start,
      // runAlignment: .start,
      children: widget.mission.linkButtons!.entries.map((e) {
        return ElevatedButton.icon(
          onPressed: () async {
            final url = Uri.parse(e.value);
            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
              throw Exception('Could not launch $url');
            }
          },
          label: Text('${e.key}'),
          icon: const Icon(Icons.arrow_forward),
          iconAlignment: .end,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWideScreen = width > 850;

    if (isWideScreen) {
      return buildLandscape(context);
    } else {
      return buildPortrait(context);
    }
  }

  Widget buildLandscape(BuildContext context) {
    final cardPadding = 16.0;

    return Card(
      elevation: 3,
      clipBehavior: .antiAlias,
      shape: RoundedRectangleBorder(borderRadius: .circular(4)),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: .fromLTRB(cardPadding, cardPadding, cardPadding, 0),
            child: titleText(context),
          ),
          Padding(
            padding: .symmetric(vertical: 0, horizontal: cardPadding),
            child: const Divider(height: 24, thickness: 1),
          ),
          Padding(
            padding: .symmetric(vertical: 0, horizontal: cardPadding),
            child: Row(
              children: [
                Expanded(flex: 3, child: descriptionText(context)),
                Expanded(flex: 1, child: illustrationImage(context, isLoading)),
              ],
            ),
          ),
          spacer(height: 12),
          Container(
            width: .infinity,
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: .all(cardPadding),
            child: Row(
              children: [
                Expanded(flex: 7, child: tagsWidget(context)),
                Expanded(flex: 3, child: linkButtonsWidget(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPortrait(BuildContext context) {
    final cardPadding = 16.0;

    return Card(
      elevation: 3,
      clipBehavior: .antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: .fromLTRB(cardPadding, cardPadding, cardPadding, 0),
            child: titleText(context),
          ),
          const Divider(height: 24, thickness: 1),
          Padding(
            padding: .symmetric(vertical: 0, horizontal: cardPadding),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                descriptionText(context),
                Center(child: illustrationImage(context, isLoading)),
              ],
            ),
          ),
          spacer(height: 12),
          Container(
            width: .infinity,
            padding: .all(cardPadding),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                tagsWidget(context),
                spacer(height: 24),
                linkButtonsWidget(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
