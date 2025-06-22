import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioService extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;
  int? _currentSongIndex;
  bool? _hideMini = true;

  // Getters
  AudioPlayer get audioPlayer => _audioPlayer;
  PlayerState? get playerState => _playerState;
  Duration? get duration => _duration;
  Duration? get position => _position;
  int? get currentSongIndex => _currentSongIndex;
  bool? get hideMini => _hideMini;

  // Constructor
  AudioService() {
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _audioPlayer.setReleaseMode(ReleaseMode.stop);

    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _playerState = state;
      notifyListeners();
    });

    // Listen to duration changes
    _audioPlayer.onDurationChanged.listen((duration) {
      _duration = duration;
      notifyListeners();
    });

    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((position) {
      _position = position;
      notifyListeners();
    });

    // Listen to completion
    _audioPlayer.onPlayerComplete.listen((_) {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
      notifyListeners();
    });
  }

  Future<void> setSource(String url) async {
    await _audioPlayer.setSource(UrlSource(url));
  }

  Future<void> play() async {
    await _audioPlayer.resume();
    _playerState = PlayerState.playing;
    notifyListeners();
  }

  // Future<void> playNext() async {
  //   await _audioPlayer.pause();
  //   _playerState = PlayerState.paused;
  //   notifyListeners();
  // }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _playerState = PlayerState.paused;
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _playerState = PlayerState.stopped;
    _position = Duration.zero;
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void setCurrentSongIndex(int index) {
    _currentSongIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
