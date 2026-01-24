// Core
import 'package:flutter/material.dart';

// Portfolio
import 'package:portfolio/supports/theme.dart';

class Timeline extends StatelessWidget {
  final List<Widget> children;

  const Timeline({super.key, required this.children});

  Widget _normalLine() =>
      Container(width: 2, color: normalPrimary.withValues(alpha: .4));

  Widget _fadedLine() => ShaderMask(
    shaderCallback: (bounds) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Colors.black],
      ).createShader(bounds);
    },
    blendMode: .dstIn,
    child: Container(width: 2, color: normalPrimary.withValues(alpha: .4)),
  );

  Widget dot(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(color: normalPrimary, shape: .circle),
      child: Center(
        child: Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: .circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      itemCount: children.length,
      itemBuilder: (context, index) {
        final isFirst = index == 0;
        final isLast = index == children.length - 1;

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: children[index],
            ),

            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: isFirst ? _fadedLine() : _normalLine(),
                  ),

                  dot(context),

                  Expanded(
                    flex: 4,
                    child: isLast
                        ? const SizedBox.shrink()
                        : Container(
                            width: 2,
                            color: normalPrimary.withValues(alpha: .4),
                          ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
