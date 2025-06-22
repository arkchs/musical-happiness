import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:headway/constants/theme_colors.dart';
import 'package:headway/services/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:headway/utils/play_controls.dart';

class PlayerPage extends StatefulWidget {
  PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  int selectedIndex = 0;
  final AudioService _audioService = AudioService();
  String? _audioUrl;

  @override
  void initState() {
    super.initState();
    _fetchAudioUrl();
    _audioService.addListener(_audioListener);
  }

  Future<void> _fetchAudioUrl() async {
    final response = await http
        .get(Uri.parse('https://musical-happiness.onrender.com/book'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final url = data['audioFile']; // must be a direct .mp3 or streamable URL

      setState(() {
        _audioUrl = url;
      });

      if (_audioUrl != null) {
        await _audioService.setSource(_audioUrl!);
      }
    }
  }

  bool _isPlaying = false;

  void _audioListener() {
    setState(() {
      _isPlaying = _audioService.playerState == PlayerState.playing;
    });
  }

  @override
  void dispose() {
    _audioService.removeListener(_audioListener);
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: kInactiveDotColor,
                      border: Border.all(color: Colors.white, width: .5),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(60.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildIconButton(icon: Icons.add, index: 1),
                      const SizedBox(width: 10),
                      _buildIconButton(icon: Icons.headphones, index: 0),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/images/placeholder.jpg',
                      height: size.height * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'KEY POINT 1 OUT OF 10',
                      style: kTextTheme.headlineSmall,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Good habits produce results that multiply',
                      style: kTextTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('0.0', style: kTextTheme.bodyLarge),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: const RoundSliderOverlayShape(),
                          ),
                          child: Expanded(
                            child: Slider(
                              onChanged: (value) {},
                              value: 0.0,
                            ),
                          ),
                        ),
                        Text('0.0', style: kTextTheme.bodyLarge),
                      ],
                    ),
                  ),
                  CustomUtilityOptions(
                      audioService: _audioService, isPlaying: _isPlaying)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required int index}) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.6) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 30,
          color: kWhiteColor,
        ),
      ),
    );
  }
}
