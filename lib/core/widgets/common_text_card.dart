import 'package:flutter/material.dart';
import '../../core/services/tts_service.dart';
import '../../features/bangla/models/day_month_model.dart';

/// Common widget for text-only cards (Days/Months)
/// Used by: MasCard, DinCard, EnglishMonthCard, EnglishDayCard
class CommonTextCard extends StatefulWidget {
  final DayMonthModel item;
  final int index;
  final TextStyle textStyle;
  final double fontSize;
  final List<List<Color>> colorPalette;
  final TtsService? ttsService; // Optional TTS service

  const CommonTextCard({
    super.key,
    required this.item,
    required this.index,
    required this.textStyle,
    required this.fontSize,
    required this.colorPalette,
    this.ttsService, // Optional parameter
  });

  @override
  State<CommonTextCard> createState() => _CommonTextCardState();
}

class _CommonTextCardState extends State<CommonTextCard> {
  void _onTtsStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Only register handler if TTS service is provided
    if (widget.ttsService != null) {
      widget.ttsService!.addStateChangeHandler(_onTtsStateChanged);
    }
  }

  @override
  void dispose() {
    // Only remove handler if TTS service was provided
    if (widget.ttsService != null) {
      widget.ttsService!.removeStateChangeHandler(_onTtsStateChanged);
    }
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    // Only play audio if service is provided
    if (widget.ttsService == null) {
      return;
    }

    if (widget.ttsService!.isSpeakingText(widget.item.name)) {
      await widget.ttsService!.stop();
    } else {
      await widget.ttsService!.speak(widget.item.name);
    }
    if (mounted) {
      setState(() {});
    }
  }

  List<Color> _getCardColors(int index) {
    return widget.colorPalette[index % widget.colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(widget.index);

    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.ttsService != null ? _togglePlayStop : null,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: cardColors,
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.item.name,
                  style: widget.textStyle.copyWith(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
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
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
