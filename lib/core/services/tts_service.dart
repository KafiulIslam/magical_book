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
      await _flutterTts.awaitSpeakCompletion(true);

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
      _isInitialized = true;
    }
  }

  /// Try to set a female voice for the given language
  Future<void> _setFemaleVoice(String languageCode) async {
    try {
      List<dynamic> voices = await _flutterTts.getVoices;
      
      // Filter voices for the current language
      var langVoices = voices.where((voice) => 
        voice['locale'].toString().toLowerCase().contains(languageCode.toLowerCase().replaceAll('-', '_')) ||
        voice['locale'].toString().toLowerCase().contains(languageCode.toLowerCase().replaceAll('_', '-'))
      ).toList();

      if (langVoices.isEmpty) return;

      // Look for voices with 'female' in their name
      var femaleVoice = langVoices.firstWhere(
        (voice) => voice['name'].toString().toLowerCase().contains('female'),
        orElse: () => null,
      );

      // On some platforms (like iOS), we can try to find specific female names if 'female' tag is missing
      if (femaleVoice == null) {
        femaleVoice = langVoices.firstWhere(
          (voice) => 
            voice['name'].toString().toLowerCase().contains('samantha') || 
            voice['name'].toString().toLowerCase().contains('victoria') ||
            voice['name'].toString().toLowerCase().contains('kanya') || // Thai female
            voice['name'].toString().toLowerCase().contains('niloufar'), // Persian female
          orElse: () => null,
        );
      }

      // If still no female voice found, just pick the second one if it exists (often voices come in pairs M/F)
      if (femaleVoice == null && langVoices.length > 1) {
        femaleVoice = langVoices[1];
      } else if (femaleVoice == null) {
        femaleVoice = langVoices.first;
      }

      if (femaleVoice != null) {
        await _flutterTts.setVoice({"name": femaleVoice["name"], "locale": femaleVoice["locale"]});
      }
    } catch (e) {
      // Silently fail if voice setting fails
    }
  }

  /// Check if text contains only English/ASCII characters
  bool _isEnglishText(String text) {
    return text.runes.every((rune) => rune < 128);
  }

  /// Set language and female voice based on text content
  Future<void> _setLanguageForText(String text) async {
    if (_isEnglishText(text)) {
      // Set to English
      try {
        await _flutterTts.setLanguage('en-US');
        await _setFemaleVoice('en-US');
      } catch (_) {
        try {
          await _flutterTts.setLanguage('en-GB');
          await _setFemaleVoice('en-GB');
        } catch (_) {
          // Use default if English is not available
        }
      }
    } else {
      // Set to Bangla
      try {
        await _flutterTts.setLanguage('bn-BD');
        await _setFemaleVoice('bn-BD');
      } catch (_) {
        try {
          await _flutterTts.setLanguage('bn-IN');
          await _setFemaleVoice('bn-IN');
        } catch (_) {
          // Use default language if Bangla is not available
        }
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

      // Set language based on text content
      await _setLanguageForText(text);

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
