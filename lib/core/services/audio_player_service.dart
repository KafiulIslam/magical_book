import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;
  AudioPlayerService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudioPath;
  bool _isPlaying = false;

  /// Play audio from asset path
  Future<void> play(String audioPath) async {
    if (audioPath.isEmpty) return;

    try {
      // If the same audio is already playing, stop it
      if (_isPlaying && _currentAudioPath == audioPath) {
        await stop();
        return;
      }

      // Stop any ongoing audio
      if (_isPlaying) {
        await _audioPlayer.stop();
      }

      // Play the audio
      _isPlaying = true;
      _currentAudioPath = audioPath;
      // Remove 'assets/' prefix for AssetSource
      final sourcePath = audioPath.startsWith('assets/')
          ? audioPath.substring(7)
          : audioPath;
      await _audioPlayer.play(AssetSource(sourcePath));
    } catch (e) {
      _isPlaying = false;
      _currentAudioPath = null;
      // Silently handle errors - audio might not be available
    }
  }

  /// Stop current audio
  Future<void> stop() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentAudioPath = null;
    }
  }

  /// Check if a specific audio is currently playing
  bool isPlayingAudio(String audioPath) {
    return _isPlaying && _currentAudioPath == audioPath;
  }

  /// Check if any audio is currently playing
  bool get isPlaying => _isPlaying;

  /// Get current playing audio path
  String? get currentAudioPath => _currentAudioPath;

  /// Set completion handler callback
  void setCompletionHandler(VoidCallback? callback) {
    _audioPlayer.onPlayerComplete.listen((event) {
      _isPlaying = false;
      _currentAudioPath = null;
      callback?.call();
    });
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
    _isPlaying = false;
    _currentAudioPath = null;
  }
}
