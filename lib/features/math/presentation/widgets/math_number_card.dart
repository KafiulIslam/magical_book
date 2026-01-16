import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/tts_service.dart';

/// Common widget for alphabet/letter cards (large text-only)
/// Used by: BornoCard, EnglishAlphabetCard
class MathNumberCard extends StatefulWidget {
  final String letter;
  final String? fontFamily;
  final List<List<Color>> colorPalette;
  final TtsService ttsService;

  const MathNumberCard({
    super.key,
    required this.letter,
    this.fontFamily,
    required this.colorPalette,
    required this.ttsService,
  });

  @override
  State<MathNumberCard> createState() => _MathNumberCardState();
}

class _MathNumberCardState extends State<MathNumberCard> {
  void _onTtsStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.ttsService.addStateChangeHandler(_onTtsStateChanged);
  }

  @override
  void dispose() {
    widget.ttsService.removeStateChangeHandler(_onTtsStateChanged);
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    if (widget.ttsService.isSpeakingText(widget.letter)) {
      await widget.ttsService.stop();
    } else {
      await widget.ttsService.speak(widget.letter);
    }
  }

  List<Color> _getCardColors(int index) {
    return widget.colorPalette[index % widget.colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(widget.letter.hashCode);
    final isPlaying = widget.ttsService.isSpeakingText(widget.letter);

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
              color: Colors.white.withOpacity(0.3),
              width: 2,
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
        ),
      ),
    );
  }
}
