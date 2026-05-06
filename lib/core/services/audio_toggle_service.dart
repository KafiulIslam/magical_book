import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioToggleService {
  static final AudioToggleService _instance = AudioToggleService._internal();
  factory AudioToggleService() => _instance;
  AudioToggleService._internal();

  static const String _featurePrefix = 'audio_feature_';
  static const String _cardPrefix = 'audio_card_';

  SharedPreferences? _prefs;
  bool _isInitialized = false;
  final Map<String, bool> _featureEnabled = {};
  final Map<String, bool> _cardEnabled = {};
  final List<VoidCallback> _stateChangeCallbacks = [];

  Future<void> initialize() async {
    if (_isInitialized) return;
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  String _featureKey(String featureKey) => '$_featurePrefix$featureKey';
  String _cardKey(String featureKey, String cardId) =>
      '$_cardPrefix$featureKey::$cardId';

  bool isFeatureEnabled(String featureKey) {
    final key = _featureKey(featureKey);
    if (_featureEnabled.containsKey(key)) {
      return _featureEnabled[key]!;
    }
    final value = _prefs?.getBool(key) ?? true;
    _featureEnabled[key] = value;
    return value;
  }

  bool isCardEnabled(String featureKey, String cardId) {
    final key = _cardKey(featureKey, cardId);
    if (_cardEnabled.containsKey(key)) {
      return _cardEnabled[key]!;
    }
    final value = _prefs?.getBool(key) ?? true;
    _cardEnabled[key] = value;
    return value;
  }

  bool isPlayable(String featureKey, String cardId) {
    return isFeatureEnabled(featureKey) && isCardEnabled(featureKey, cardId);
  }

  Future<bool> toggleFeature(String featureKey) async {
    await initialize();
    final key = _featureKey(featureKey);
    final next = !isFeatureEnabled(featureKey);
    _featureEnabled[key] = next;
    await _prefs?.setBool(key, next);
    _notifyStateChange();
    return next;
  }

  Future<bool> toggleCard(String featureKey, String cardId) async {
    await initialize();
    final key = _cardKey(featureKey, cardId);
    final next = !isCardEnabled(featureKey, cardId);
    _cardEnabled[key] = next;
    await _prefs?.setBool(key, next);
    _notifyStateChange();
    return next;
  }

  void addStateChangeHandler(VoidCallback callback) {
    if (!_stateChangeCallbacks.contains(callback)) {
      _stateChangeCallbacks.add(callback);
    }
  }

  void removeStateChangeHandler(VoidCallback callback) {
    _stateChangeCallbacks.remove(callback);
  }

  void _notifyStateChange() {
    for (final callback in _stateChangeCallbacks) {
      callback();
    }
  }
}
