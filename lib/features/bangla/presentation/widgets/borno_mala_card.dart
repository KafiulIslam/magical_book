import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/audio_player_service.dart';

/// Common widget for alphabet/letter cards (large text-only)
/// Used by: BornoMalaScreen
class BornoMalaCard extends StatefulWidget {
  final String letter;
  final String? fontFamily;
  final List<List<Color>> colorPalette;
  final String? audioPath;

  const BornoMalaCard({
    super.key,
    required this.letter,
    this.fontFamily,
    required this.colorPalette,
    this.audioPath,
  });

  @override
  State<BornoMalaCard> createState() => _BornoMalaCardState();
}

class _BornoMalaCardState extends State<BornoMalaCard> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  void _onAudioStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _audioPlayerService.addStateChangeHandler(_onAudioStateChanged);
  }

  @override
  void dispose() {
    _audioPlayerService.removeStateChangeHandler(_onAudioStateChanged);
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    if (widget.audioPath == null || widget.audioPath!.isEmpty) return;

    if (_audioPlayerService.isPlayingAudio(widget.audioPath!)) {
      await _audioPlayerService.stop();
    } else {
      await _audioPlayerService.play(widget.audioPath!);
    }
  }

  List<Color> _getCardColors(int index) {
    return widget.colorPalette[index % widget.colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(widget.letter.hashCode);
    final isPlaying = widget.audioPath != null && widget.audioPath!.isNotEmpty
        ? _audioPlayerService.isPlayingAudio(widget.audioPath!)
        : false;

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
