import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;
  AudioPlayerService._internal() {
    _audioPlayer.onPlayerComplete.listen((event) {
      _isPlaying = false;
      _currentAudioPath = null;
      _currentItemId = null;
      _notifyStateChange();
      _notifyCompletion();
    });
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudioPath;
  String? _currentItemId; // Track by item ID for unique identification
  bool _isPlaying = false;
  final List<VoidCallback> _stateChangeCallbacks = [];
  final List<VoidCallback> _completionCallbacks = [];

  /// Play audio from asset path with optional item ID for unique identification
  Future<void> play(String audioPath, {String? itemId}) async {
    if (audioPath.isEmpty) return;

    try {
      // If the same item is already playing, stop it
      if (_isPlaying && _currentItemId == itemId && itemId != null) {
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
      _currentItemId = itemId;
      // Remove 'assets/' prefix for AssetSource
      final sourcePath =
          audioPath.startsWith('assets/') ? audioPath.substring(7) : audioPath;
      await _audioPlayer.play(AssetSource(sourcePath));
      _notifyStateChange();
    } catch (e) {
      _isPlaying = false;
      _currentAudioPath = null;
      _currentItemId = null;
      // Silently handle errors - audio might not be available
    }
  }

  /// Stop current audio
  Future<void> stop() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentAudioPath = null;
      _currentItemId = null;
      _notifyStateChange();
    }
  }

  void _notifyCompletion() {
    for (final callback in _completionCallbacks) {
      callback();
    }
  }

  /// Notify all registered callbacks of state change
  void _notifyStateChange() {
    for (final callback in _stateChangeCallbacks) {
      callback();
    }
  }

  /// Check if a specific audio is currently playing (by audio path)
  bool isPlayingAudio(String audioPath) {
    return _isPlaying && _currentAudioPath == audioPath;
  }

  /// Check if a specific item is currently playing (by item ID)
  bool isPlayingItem(String itemId) {
    return _isPlaying && _currentItemId == itemId;
  }

  /// Check if any audio is currently playing
  bool get isPlaying => _isPlaying;

  /// Get current playing audio path
  String? get currentAudioPath => _currentAudioPath;

  /// Set completion handler callback
  void setCompletionHandler(VoidCallback? callback) {
    // Backward-compatible behavior: treat this as "add" (without duplicates).
    if (callback == null) return;
    addCompletionHandler(callback);
  }

  /// Add completion callback (called when the current audio finishes)
  void addCompletionHandler(VoidCallback callback) {
    if (!_completionCallbacks.contains(callback)) {
      _completionCallbacks.add(callback);
    }
  }

  /// Remove completion callback
  void removeCompletionHandler(VoidCallback callback) {
    _completionCallbacks.remove(callback);
  }

  /// Add state change callback (called when play/stop state changes)
  void addStateChangeHandler(VoidCallback callback) {
    if (!_stateChangeCallbacks.contains(callback)) {
      _stateChangeCallbacks.add(callback);
    }
  }

  /// Remove state change callback
  void removeStateChangeHandler(VoidCallback callback) {
    _stateChangeCallbacks.remove(callback);
  }

  /// Dispose resources
  Future<void> dispose() async {
    // This service is a singleton shared across the whole app.
    // Do NOT dispose the underlying AudioPlayer from individual screens.
    await stop();
  }
}
