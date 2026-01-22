import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/tts_service.dart';
import '../../model/figure_model.dart';

/// Common widget for figure/shape cards (icon + text)
/// Used by: EnglishFigureScreen
class FigureCard extends StatefulWidget {
  final FigureModel figure;
  final int index;
  final TextStyle textStyle;
  final double fontSize;
  final List<List<Color>> colorPalette;
  final TtsService ttsService;

  const FigureCard({
    super.key,
    required this.figure,
    required this.index,
    required this.textStyle,
    required this.fontSize,
    required this.colorPalette,
    required this.ttsService,
  });

  @override
  State<FigureCard> createState() => _FigureCardState();
}

class _FigureCardState extends State<FigureCard> {
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
    if (widget.ttsService.isSpeakingText(widget.figure.title)) {
      await widget.ttsService.stop();
    } else {
      await widget.ttsService.speak(widget.figure.title);
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
          onTap: _togglePlayStop,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Expanded(
                  flex: 3,
                  child: Icon(
                    widget.figure.image,
                    size: 100.sp,
                    color: Colors.white,
                  ),
                ),
                // Figure Name
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Center(
                      child: Text(
                        widget.figure.title,
                        style: widget.textStyle.copyWith(
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
