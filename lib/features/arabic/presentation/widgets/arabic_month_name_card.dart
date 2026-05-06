import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../model/arabic_month_model.dart';

/// Card for one Hijri month: Arabic script, transliteration, Bangla; tap for TTS.
class ArabicMonthNameCard extends StatefulWidget {
  final ArabicMonthModel month;
  final int index;
  final List<List<Color>> colorPalette;
  final TtsService ttsService;

  const ArabicMonthNameCard({
    super.key,
    required this.month,
    required this.index,
    required this.colorPalette,
    required this.ttsService,
  });

  @override
  State<ArabicMonthNameCard> createState() => _ArabicMonthNameCardState();
}

class _ArabicMonthNameCardState extends State<ArabicMonthNameCard> {
  /// Must match exactly what is passed to [TtsService.speak] for playing state.
  // String get _speakText =>
  //     '${widget.month.arabicName}, ${widget.month.transliteration}, ${widget.month.banglaName}';

  String get _speakText =>
      '${widget.month.transliteration}, ${widget.month.banglaName}';

  void _onTtsChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.ttsService.addStateChangeHandler(_onTtsChanged);
  }

  @override
  void dispose() {
    widget.ttsService.removeStateChangeHandler(_onTtsChanged);
    super.dispose();
  }

  Future<void> _toggle() async {
    if (widget.ttsService.isSpeakingText(_speakText)) {
      await widget.ttsService.stop();
    } else {
      await widget.ttsService.speak(_speakText);
    }
    if (mounted) setState(() {});
  }

  List<Color> _colors() =>
      widget.colorPalette[widget.index % widget.colorPalette.length];

  @override
  Widget build(BuildContext context) {
    final cardColors = _colors();
    final isPlaying = widget.ttsService.isSpeakingText(_speakText);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _toggle,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: cardColors,
            ),
            border: Border.all(
              color: isPlaying ? Colors.white : Colors.white.withOpacity(0.35),
              width: isPlaying ? 3 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: cardColors[0].withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.month.arabicName,
                style: ArabicTypo.headline2.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.2,
                  shadows: const [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.h),
              Text(
                widget.month.transliteration,
                style: EnglishTypo.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.95),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                widget.month.banglaName,
                style: BanglaTypo.bodyLarge.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
