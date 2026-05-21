import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/services/audio_toggle_service.dart';
import '../../../../core/services/tts_service.dart';

/// Common widget for alphabet/letter cards (large text-only)
/// Used by: BornoCard, EnglishAlphabetCard
class MathNumberCard extends StatefulWidget {
  final String letter;
  final String? fontFamily;
  final List<List<Color>> colorPalette;
  final TtsService ttsService;
  final String featureKey;
  final String cardId;
  final String? audioPath;

  const MathNumberCard({
    super.key,
    required this.letter,
    this.fontFamily,
    required this.colorPalette,
    required this.ttsService,
    required this.featureKey,
    required this.cardId,
    this.audioPath,
  });

  @override
  State<MathNumberCard> createState() => _MathNumberCardState();
}

class _MathNumberCardState extends State<MathNumberCard> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  final AudioToggleService _audioToggleService = AudioToggleService();

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  bool get _hasAudio =>
      widget.audioPath != null && widget.audioPath!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    widget.ttsService.addStateChangeHandler(_onStateChanged);
    if (_hasAudio) {
      _audioPlayerService.addStateChangeHandler(_onStateChanged);
      _audioPlayerService.addCompletionHandler(_onStateChanged);
    }
    _audioToggleService.initialize();
    _audioToggleService.addStateChangeHandler(_onStateChanged);
  }

  @override
  void dispose() {
    widget.ttsService.removeStateChangeHandler(_onStateChanged);
    if (_hasAudio) {
      _audioPlayerService.removeStateChangeHandler(_onStateChanged);
      _audioPlayerService.removeCompletionHandler(_onStateChanged);
    }
    _audioToggleService.removeStateChangeHandler(_onStateChanged);
    super.dispose();
  }

  /// Convert English number to word for better TTS pronunciation
  String _numberToWord(String number) {
    const numberWords = {
      '0': 'zero',
      '1': 'one',
      '2': 'two',
      '3': 'three',
      '4': 'four',
      '5': 'five',
      '6': 'six',
      '7': 'seven',
      '8': 'eight',
      '9': 'nine',
      '10': 'ten',
    };
    return numberWords[number] ?? number;
  }

  /// Check if the number is English (contains only ASCII digits)
  bool _isEnglishNumber(String text) {
    return RegExp(r'^[0-9]+$').hasMatch(text);
  }

  Future<void> _togglePlayStop() async {
    if (!_audioToggleService.isPlayable(widget.featureKey, widget.cardId)) {
      return;
    }

    if (_hasAudio) {
      if (_audioPlayerService.isPlayingAudio(widget.audioPath!)) {
        await _audioPlayerService.stop();
      } else {
        await _audioPlayerService.play(
          widget.audioPath!,
          itemId: widget.cardId,
        );
      }
      return;
    }

    // Convert English number to word for better pronunciation
    final textToSpeak = _isEnglishNumber(widget.letter)
        ? _numberToWord(widget.letter)
        : widget.letter;

    if (widget.ttsService.isSpeakingText(textToSpeak)) {
      await widget.ttsService.stop();
    } else {
      await widget.ttsService.speak(textToSpeak);
    }
  }

  List<Color> _getCardColors(int index) {
    return widget.colorPalette[index % widget.colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(widget.letter.hashCode);
    final isEnabled =
        _audioToggleService.isPlayable(widget.featureKey, widget.cardId);
    final textToSpeak = _isEnglishNumber(widget.letter)
        ? _numberToWord(widget.letter)
        : widget.letter;
    final isPlaying = _hasAudio
        ? _audioPlayerService.isPlayingAudio(widget.audioPath!)
        : widget.ttsService.isSpeakingText(textToSpeak);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: cardColors[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: InkWell(
        onTap: _togglePlayStop,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                cardColors[0],
                cardColors[1],
              ],
            ),
            border: Border.all(
              color: isPlaying ? Colors.white : Colors.white.withOpacity(0.3),
              width: isPlaying ? 3 : 2,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  widget.letter,
                  style: TextStyle(
                    fontFamily: widget.fontFamily,
                    fontSize: 72.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.0,
                    letterSpacing: 0,
                    shadows: const [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _audioToggleService.toggleCard(
                      widget.featureKey,
                      widget.cardId,
                    ),
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Icon(
                        isEnabled ? Icons.volume_up : Icons.volume_off,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
