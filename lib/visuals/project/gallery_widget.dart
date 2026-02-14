// Core
import 'package:flutter/material.dart';

// External
import 'package:auto_size_text/auto_size_text.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// Portfolio
import 'package:portfolio/models/section.dart';
import 'package:portfolio/services/storage.dart';

class GalleryWidget extends StatefulWidget {
  final Gallery gallery;

  const GalleryWidget({super.key, required this.gallery});

  @override
  State<GalleryWidget> createState() => GalleryWidgetState();
}

class GalleryWidgetState extends State<GalleryWidget> {
  bool isLoading = true;

  int currentIndex = 0;

  List<String> illustrationsName = [];

  @override
  void initState() {
    super.initState();

    fetchIllustrations();
  }

  void fetchIllustrations() async {
    for (var name in widget.gallery.illustrationsName!) {
      if (name.contains('youtube.com') || name.contains('youtu.be')) {
        illustrationsName.add(name);
      } else {
        final url = await FirebaseStorageService.getFile(name);
        if (url != null) {
          illustrationsName.add(url);
        }
      }
    }

    setState(() {
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
      "Galerie",
      maxLines: 1,
      minFontSize: 20,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: .bold),
    );
  }

  Widget mediaWidget(PageController controller) {
    return PageView.builder(
      controller: controller,
      itemCount: illustrationsName.length,
      onPageChanged: (i) => setState(() => currentIndex = i),
      itemBuilder: (context, index) {
        return Padding(
          padding: const .symmetric(horizontal: 12),
          child: ClipRRect(
            borderRadius: .circular(12),
            child: mediaItem(illustrationsName[index]),
          ),
        );
      },
    );
  }

  Widget mediaItem(String url) {
    if (url.contains('youtube.com') || url.contains('youtu.be')) {
      final id = YoutubePlayerController.convertUrlToId(url)!;

      final controller = YoutubePlayerController.fromVideoId(
        videoId: id,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );

      return YoutubePlayer(aspectRatio: 16 / 9, controller: controller);
    }

    return Image.network(url, fit: .cover);
  }

  Widget arrowButton(PageController controller, {bool isLeft = true}) {
    return Positioned(
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      child: IconButton(
        icon: Icon(isLeft ? Icons.chevron_left : Icons.chevron_right),
        onPressed: () {
          if (isLeft) {
            controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          } else {
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWideScreen = width > 850;

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
          isWideScreen ? buildLandscape(context) : buildPortrait(context),
          spacer(height: cardPadding),
        ],
      ),
    );
  }

  Widget buildLandscape(BuildContext context) {
    final fixedHeight = 300.0;
    final fixedWidth = 16 / 9 * fixedHeight;
    final screenWidth = MediaQuery.of(context).size.width;
    final viewPortFraction = fixedWidth / screenWidth;

    final controller = PageController(
      initialPage: currentIndex,
      viewportFraction: viewPortFraction,
    );

    return SizedBox(
      height: fixedHeight,
      child: isLoading
          ? loading()
          : Stack(
              alignment: .center,
              children: [
                Padding(
                  padding: .symmetric(horizontal: 42),
                  child: mediaWidget(controller),
                ),

                if (currentIndex > 0) arrowButton(controller, isLeft: true),

                if (currentIndex < illustrationsName.length - 1)
                  arrowButton(controller, isLeft: false),
              ],
            ),
    );
  }

  Widget buildPortrait(BuildContext context) {
    final fixedHeight = 200.0;
    final fixedWidth = 16 / 9 * fixedHeight;
    final screenWidth = MediaQuery.of(context).size.width;
    final viewPortFraction = fixedWidth / screenWidth;

    final controller = PageController(
      initialPage: currentIndex,
      viewportFraction: viewPortFraction,
    );

    return SizedBox(
      height: fixedHeight,
      child: isLoading ? loading() : mediaWidget(controller),
    );
  }
}
