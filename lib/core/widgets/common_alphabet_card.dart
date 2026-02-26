import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/services/audio_player_service.dart';
import '../../core/services/tts_service.dart';

/// Common widget for alphabet/letter cards (large text-only)
/// Used by: BornoCard, EnglishAlphabetCard
/// When [audioPath] and [audioPlayerService] are provided, plays asset audio; otherwise uses [ttsService] if provided.
class CommonAlphabetCard extends StatefulWidget {
  final String letter;
  final String? fontFamily;
  final List<List<Color>> colorPalette;
  final TtsService? ttsService;
  final String? audioPath;
  final AudioPlayerService? audioPlayerService;

  const CommonAlphabetCard({
    super.key,
    required this.letter,
    this.fontFamily,
    required this.colorPalette,
    this.ttsService,
    this.audioPath,
    this.audioPlayerService,
  });

  @override
  State<CommonAlphabetCard> createState() => _CommonAlphabetCardState();
}

class _CommonAlphabetCardState extends State<CommonAlphabetCard> {
  String get _itemId => 'english_letter_${widget.letter}';

  void _onTtsStateChanged() {
    if (mounted) setState(() {});
  }

  void _onAudioStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.ttsService != null) {
      widget.ttsService!.addStateChangeHandler(_onTtsStateChanged);
      widget.ttsService!.addCompletionHandler(_onTtsStateChanged);
    }
    if (widget.audioPlayerService != null) {
      widget.audioPlayerService!.addStateChangeHandler(_onAudioStateChanged);
      widget.audioPlayerService!.addCompletionHandler(_onAudioStateChanged);
    }
  }

  @override
  void dispose() {
    if (widget.audioPlayerService != null &&
        widget.audioPlayerService!.isPlayingItem(_itemId)) {
      widget.audioPlayerService!.stop();
    }
    if (widget.audioPlayerService != null) {
      widget.audioPlayerService!.removeStateChangeHandler(_onAudioStateChanged);
      widget.audioPlayerService!.removeCompletionHandler(_onAudioStateChanged);
    }
    if (widget.ttsService != null) {
      widget.ttsService!.removeStateChangeHandler(_onTtsStateChanged);
      widget.ttsService!.removeCompletionHandler(_onTtsStateChanged);
    }
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    if (widget.audioPath != null && widget.audioPlayerService != null) {
      if (widget.audioPlayerService!.isPlayingItem(_itemId)) {
        await widget.audioPlayerService!.stop();
      } else {
        await widget.audioPlayerService!.play(
          widget.audioPath!,
          itemId: _itemId,
        );
      }
      if (mounted) setState(() {});
      return;
    }
    if (widget.ttsService == null) return;
    if (widget.ttsService!.isSpeakingText(widget.letter)) {
      await widget.ttsService!.stop();
    } else {
      await widget.ttsService!.speak(widget.letter);
    }
  }

  List<Color> _getCardColors(int index) {
    return widget.colorPalette[index % widget.colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(widget.letter.hashCode);
    final isPlaying = widget.audioPath != null && widget.audioPlayerService != null
        ? widget.audioPlayerService!.isPlayingItem(_itemId)
        : (widget.ttsService != null
            ? widget.ttsService!.isSpeakingText(widget.letter)
            : false);

    return InkWell(
      onTap: _togglePlayStop,
      child: Container(
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
            child: Center(
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
          )),
    );
  }
}
