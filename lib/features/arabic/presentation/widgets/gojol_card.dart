import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../math/model/multiplication_model.dart';

class GojolCard extends StatefulWidget {
  final MultiplicationModel item;
  final int index;
  final TextStyle textStyle;
  final TextStyle subtitleStyle;
  final double titleFontSize;
  final double subtitleFontSize;
  final List<List<Color>> colorPalette;
  final IconData errorIcon;
  final VoidCallback? onTap;
  final AudioPlayerService audioPlayerService;

  const GojolCard({
    super.key,
    required this.item,
    required this.index,
    required this.textStyle,
    required this.subtitleStyle,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.colorPalette,
    required this.errorIcon,
    this.onTap,
    required this.audioPlayerService,
  });

  @override
  State<GojolCard> createState() => _GojolCardState();
}

class _GojolCardState extends State<GojolCard> {

  void _onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    // Listen to state changes (play/stop) to update UI
    widget.audioPlayerService.addStateChangeHandler(_onStateChanged);
    // Listen to audio completion to update UI
    widget.audioPlayerService.setCompletionHandler(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    widget.audioPlayerService.removeStateChangeHandler(_onStateChanged);
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    final itemId = widget.item.id.toString();
    if (widget.audioPlayerService.isPlayingItem(itemId)) {
      await widget.audioPlayerService.stop();
    } else {
      await widget.audioPlayerService.play(widget.item.audio, itemId: itemId);
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
    final itemId = widget.item.id.toString();
    final isPlaying = widget.audioPlayerService.isPlayingItem(itemId);

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: cardColors,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    child: Image.asset(
                      widget.item.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          widget.errorIcon,
                          size: 60,
                          color: Colors.white.withOpacity(0.7),
                        );
                      },
                    ),
                  ),
                ),
                // Title and Subtitle
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Center(
                      child: Text(
                        widget.item.subTitle,
                        style: widget.subtitleStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white.withOpacity(0.9),
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
                    ),
                  ),
                ),
              ],
            ),

            // Play/Stop Button in bottom right
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: _togglePlayStop,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.35),
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
    );
  }
}
