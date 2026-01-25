import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../services/audio_player_service.dart';
import '../theme/app_typography.dart';

/// Common widget for horizontal rhyme cards
/// Used by: ChoraCard, EnglishRhymesCard
class CommonRhymeCard extends StatefulWidget {
  final String title;
  final String image;
  final int index;
  final TextStyle textStyle;
  final List<List<Color>> colorPalette;
  final double imageWidth;
  final double imageHeight;
  final AudioPlayerService? audioPlayerService;
  final String? audioPath;
  final String? itemId;

  const CommonRhymeCard({
    super.key,
    required this.title,
    required this.image,
    required this.index,
    required this.textStyle,
    required this.colorPalette,
    this.imageWidth = 120,
    this.imageHeight = 125,
    this.audioPlayerService,
    this.audioPath,
    this.itemId,
  });

  @override
  State<CommonRhymeCard> createState() => _CommonRhymeCardState();
}

class _CommonRhymeCardState extends State<CommonRhymeCard> {
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
    if (widget.audioPlayerService != null) {
      widget.audioPlayerService!.addStateChangeHandler(_onStateChanged);
      widget.audioPlayerService!.addCompletionHandler(_onCompleted);
    }
  }

  @override
  void dispose() {
    if (widget.audioPlayerService != null) {
      widget.audioPlayerService!.removeStateChangeHandler(_onStateChanged);
      widget.audioPlayerService!.removeCompletionHandler(_onCompleted);
    }
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    if (widget.audioPlayerService == null ||
        widget.audioPath == null ||
        widget.audioPath!.isEmpty ||
        widget.itemId == null) {
      debugPrint('CommonRhymeCard: Cannot play - missing service, path, or itemId');
      return;
    }

    final isPlaying =
        widget.audioPlayerService!.isPlayingItem(widget.itemId!);
    if (isPlaying) {
      debugPrint('CommonRhymeCard: Stopping audio for itemId: ${widget.itemId}');
      await widget.audioPlayerService!.stop();
    } else {
      debugPrint('CommonRhymeCard: Playing audio: ${widget.audioPath} for itemId: ${widget.itemId}');
      await widget.audioPlayerService!.play(
        widget.audioPath!,
        itemId: widget.itemId!,
      );
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
    final isPlaying = widget.audioPlayerService != null &&
            widget.itemId != null
        ? widget.audioPlayerService!.isPlayingItem(widget.itemId!)
        : false;

    return Container(
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
                widget.image,
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
                      widget.title,
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
                    GestureDetector(
                      onTap: widget.audioPlayerService != null &&
                              widget.audioPath != null &&
                              widget.audioPath!.isNotEmpty
                          ? _togglePlayStop
                          : null,
                      behavior: HitTestBehavior.opaque,
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
                              style: EnglishTypo.headline3.copyWith(
                                  color: Colors.white, fontSize: 16.sp),
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
      );
  }
}
