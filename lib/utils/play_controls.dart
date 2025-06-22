import 'package:flutter/material.dart';
import 'package:headway/constants/theme_colors.dart';
import 'package:headway/services/audio_service.dart';

class CustomUtilityOptions extends StatelessWidget {
  final AudioService audioService;
  final bool isPlaying;
  final BorderRadiusGeometry radius = BorderRadius.circular(20.0);
  CustomUtilityOptions(
      {super.key, required this.audioService, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            key: const Key('play_previous'),
            onPressed: () {
              // Implement skip to previous logic if you have a playlist
            },
            iconSize: 40.0,
            icon: Icon(Icons.skip_previous_rounded, color: kWhiteColor),
          ),
          IconButton(
            key: const Key('backward_5'),
            onPressed: () async {
              final pos = audioService.position ?? Duration.zero;
              await audioService.seek(pos - const Duration(seconds: 5));
            },
            iconSize: 45.0,
            icon: Icon(
              Icons.replay_5_rounded,
              color: kWhiteColor,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: IconButton(
              key: ValueKey<bool>(isPlaying),
              onPressed: () async {
                if (isPlaying) {
                  await audioService.pause();
                } else {
                  await audioService.play();
                }
              },
              iconSize: 50.0,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                color: kWhiteColor,
              ),
            ),
          ),
          IconButton(
            key: const Key('forward_10'),
            onPressed: () async {
              final pos = audioService.position ?? Duration.zero;
              await audioService.seek(pos + const Duration(seconds: 10));
            },
            iconSize: 45.0,
            icon: Icon(
              Icons.forward_10_rounded,
              color: kWhiteColor,
            ),
          ),
          IconButton(
            key: const Key('play_next'),
            onPressed: () {
              // Implement skip to next logic if you have a playlist
            },
            iconSize: 40.0,
            icon: Icon(Icons.skip_next_rounded, color: kWhiteColor),
          ),
        ],
      ),
    );
  }
}

class Temp extends StatelessWidget {
  const Temp({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: [
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.pause),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          onPressed: () {},
        ),
      ],
    );
  }
}
