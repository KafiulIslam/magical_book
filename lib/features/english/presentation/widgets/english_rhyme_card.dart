import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../model/rhymes_model.dart';

class EnglishRhymeCard extends StatefulWidget {
  final RhymesModel rhyme;
  final int index;
  final TextStyle textStyle;
  final List<List<Color>> colorPalette;
  final double imageWidth;
  final double imageHeight;
  final AudioPlayerService audioPlayerService;

  const EnglishRhymeCard({
    super.key,
    required this.rhyme,
    required this.index,
    required this.textStyle,
    required this.colorPalette,
    this.imageWidth = 120,
    this.imageHeight = 125,
    required this.audioPlayerService,
  });

  @override
  State<EnglishRhymeCard> createState() => _EnglishRhymeCardState();
}

class _EnglishRhymeCardState extends State<EnglishRhymeCard> {
  void _onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onCompleted() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    // Listen to state changes (play/stop) to update UI
    widget.audioPlayerService.addStateChangeHandler(_onStateChanged);
    widget.audioPlayerService.addCompletionHandler(_onCompleted);
  }

  @override
  void dispose() {
    widget.audioPlayerService.removeStateChangeHandler(_onStateChanged);
    widget.audioPlayerService.removeCompletionHandler(_onCompleted);
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    final itemId = widget.rhyme.id.toString();
    if (widget.audioPlayerService.isPlayingItem(itemId)) {
      await widget.audioPlayerService.stop();
    } else {
      await widget.audioPlayerService.play(widget.rhyme.audio, itemId: itemId);
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
    final itemId = widget.rhyme.id.toString();
    final isPlaying = widget.audioPlayerService.isPlayingItem(itemId);

    return InkWell(
      onTap: () {
        // TODO: Navigate to rhyme detail screen if needed
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: cardColors,
          ),
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                widget.rhyme.image,
                width: widget.imageWidth.w,
                height: widget.imageHeight.h,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.music_note,
                    size: 50.sp,
                    color: Colors.white.withOpacity(0.7),
                  );
                },
              ),
            ),

            // Title and play button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.rhyme.title,
                      style: widget.textStyle.copyWith(
                        fontSize: 20.sp,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(12),
                    InkWell(
                      onTap: _togglePlayStop,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isPlaying
                                  ? Icons.stop_circle
                                  : Icons.play_circle_filled,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                            const Gap(6),
                            Text(
                              isPlaying ? 'Stop' : 'Play',
                              style: EnglishTypo.headline3
                                  .copyWith(color: Colors.white, fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
