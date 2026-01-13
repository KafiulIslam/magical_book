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

  /// Initialize TTS service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Set language to Bangla (Bangladesh)
      await _flutterTts.setLanguage('bn-BD');

      // Set speech rate (0.0 to 1.0)
      await _flutterTts.setSpeechRate(0.5);

      // Set volume (0.0 to 1.0)
      await _flutterTts.setVolume(1.0);

      // Set pitch (0.5 to 2.0)
      await _flutterTts.setPitch(1.0);

      // Set completion handler
      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
        _currentText = null;
      });

      // Set error handler
      _flutterTts.setErrorHandler((msg) {
        _isSpeaking = false;
        _currentText = null;
      });

      _isInitialized = true;
    } catch (e) {
      // If bn-BD is not available, try bn-IN or default
      try {
        await _flutterTts.setLanguage('bn-IN');
        _isInitialized = true;
      } catch (e2) {
        // Use default language if Bangla is not available
        _isInitialized = true;
      }
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
      await _flutterTts.speak(text);
    } catch (e) {
      _isSpeaking = false;
      _currentText = null;
      // Silently handle errors - TTS might not be available on all devices
    }
  }

  /// Stop current speech
  Future<void> stop() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
      _currentText = null;
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
    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      _currentText = null;
      callback?.call();
    });
  }

  /// Set error handler callback
  void setErrorHandler(Function(String)? callback) {
    _flutterTts.setErrorHandler((msg) {
      _isSpeaking = false;
      _currentText = null;
      callback?.call(msg);
    });
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _flutterTts.stop();
    _isSpeaking = false;
    _currentText = null;
  }
}
