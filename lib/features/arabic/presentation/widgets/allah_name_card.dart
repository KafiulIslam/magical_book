import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:magical_book/core/theme/app_typography.dart';
import '../../../../core/services/tts_service.dart';
import '../../model/allah_name_model.dart';

class AllahNameCard extends StatefulWidget {
  final AllahNameModel name;
  final int index;
  final List<List<Color>> colorPalette;
  final TtsService ttsService;

  const AllahNameCard({
    super.key,
    required this.name,
    required this.index,
    required this.colorPalette,
    required this.ttsService,
  });

  @override
  State<AllahNameCard> createState() => _AllahNameCardState();
}

class _AllahNameCardState extends State<AllahNameCard> {
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
    if (widget.ttsService.isSpeakingText(widget.name.banglaPronunciation)) {
      await widget.ttsService.stop();
    } else {

      await widget.ttsService.speak(widget.name.banglaPronunciation);
    }
  }

  List<Color> _getCardColors(int index) {
    return widget.colorPalette[index % widget.colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(widget.index);
    final isPlaying =
        widget.ttsService.isSpeakingText(widget.name.banglaPronunciation);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Number and Arabic Name
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${widget.name.id}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.name.arabicName,
                          style: TextStyle(
                            fontFamily: 'NotoSansArabic',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.2,
                            shadows: const [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  // Bangla Pronunciation
                  Text(
                    widget.name.banglaPronunciation,
                    style: BanglaTypo.headline3.copyWith(
                      fontSize: 18.sp,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  // Bangla Meaning
                  Text(
                    widget.name.banglaMeaning,
                    style: BanglaTypo.headline4.copyWith(
                      fontSize: 14.sp,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              // Play/Stop Button in bottom right
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: _togglePlayStop,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isPlaying ? Icons.stop : Icons.play_arrow,
                      color: Colors.white,
                      size: 24.sp,
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
