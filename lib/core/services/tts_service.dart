import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  bool _isSpeaking = false;
  String? _currentText;
  final List<VoidCallback> _stateChangeCallbacks = [];
  final List<VoidCallback> _completionCallbacks = [];

  /// Initialize TTS service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Make completion callbacks reliable across platforms.
      // (On some platforms completion won't fire unless this is enabled.)
      await _flutterTts.awaitSpeakCompletion(true);

      // Set speech rate (0.0 to 1.0)
      await _flutterTts.setSpeechRate(0.5);

      // Set volume (0.0 to 1.0)
      await _flutterTts.setVolume(1.0);

      // Set pitch (0.5 to 2.0)
      await _flutterTts.setPitch(1.0);

      // Best-effort: Set language to Bangla (Bangladesh), then fallback.
      try {
        await _flutterTts.setLanguage('bn-BD');
      } catch (_) {
        try {
          await _flutterTts.setLanguage('bn-IN');
        } catch (_) {
          // Use default language if Bangla is not available
        }
      }

      // Set completion handler
      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
        _currentText = null;
        _notifyStateChange();
        _notifyCompletion();
      });

      // Set error handler
      _flutterTts.setErrorHandler((msg) {
        _isSpeaking = false;
        _currentText = null;
        _notifyStateChange();
      });

      _isInitialized = true;
    } catch (e) {
      // Even if initialization fails partially, mark initialized to avoid loops.
      _isInitialized = true;
    }
  }

  /// Speak the given text
  Future<void> speak(String text) async {
    if (text.isEmpty) return;

    try {
      // Initialize if not already done
      if (!_isInitialized) {
        await initialize();
      }

      // If the same text is already playing, stop it
      if (_isSpeaking && _currentText == text) {
        await stop();
        return;
      }

      // Stop any ongoing speech
      if (_isSpeaking) {
        await _flutterTts.stop();
      }

      // Speak the text
      _isSpeaking = true;
      _currentText = text;
      _notifyStateChange();
      await _flutterTts.speak(text);
    } catch (e) {
      _isSpeaking = false;
      _currentText = null;
      _notifyStateChange();
      // Silently handle errors - TTS might not be available on all devices
    }
  }

  /// Stop current speech
  Future<void> stop() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
      _currentText = null;
      _notifyStateChange();
    }
  }

  void _notifyStateChange() {
    for (final callback in _stateChangeCallbacks) {
      callback();
    }
  }

  void _notifyCompletion() {
    for (final callback in _completionCallbacks) {
      callback();
    }
  }

  /// Check if a specific text is currently being spoken
  bool isSpeakingText(String text) {
    return _isSpeaking && _currentText == text;
  }

  /// Check if TTS is currently speaking
  bool get isSpeaking => _isSpeaking;

  /// Set completion handler callback
  void setCompletionHandler(VoidCallback? callback) {
    // Backward-compatible behavior: treat this as "add" (without duplicates).
    if (callback == null) return;
    addCompletionHandler(callback);
  }

  /// Set error handler callback
  void setErrorHandler(Function(String)? callback) {
    _flutterTts.setErrorHandler((msg) {
      _isSpeaking = false;
      _currentText = null;
      _notifyStateChange();
      callback?.call(msg);
    });
  }

  /// Add completion callback (called when speech finishes)
  void addCompletionHandler(VoidCallback callback) {
    if (!_completionCallbacks.contains(callback)) {
      _completionCallbacks.add(callback);
    }
  }

  /// Remove completion callback
  void removeCompletionHandler(VoidCallback callback) {
    _completionCallbacks.remove(callback);
  }

  /// Add state change callback (called when speak/stop state changes)
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
    // Do NOT dispose plugin resources from individual screens.
    await stop();
  }
}
