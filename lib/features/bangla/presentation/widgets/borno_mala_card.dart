import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/services/audio_toggle_service.dart';

/// Common widget for alphabet/letter cards (large text-only)
/// Used by: BornoMalaScreen
class BornoMalaCard extends StatefulWidget {
  final String letter;
  final String? fontFamily;
  final List<List<Color>> colorPalette;
  final String? audioPath;
  final String featureKey;
  final String cardId;

  const BornoMalaCard({
    super.key,
    required this.letter,
    this.fontFamily,
    required this.colorPalette,
    this.audioPath,
    required this.featureKey,
    required this.cardId,
  });

  @override
  State<BornoMalaCard> createState() => _BornoMalaCardState();
}

class _BornoMalaCardState extends State<BornoMalaCard> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  final AudioToggleService _audioToggleService = AudioToggleService();

  void _onAudioStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _audioPlayerService.addStateChangeHandler(_onAudioStateChanged);
    _audioToggleService.initialize();
    _audioToggleService.addStateChangeHandler(_onAudioStateChanged);
  }

  @override
  void dispose() {
    _audioPlayerService.removeStateChangeHandler(_onAudioStateChanged);
    _audioToggleService.removeStateChangeHandler(_onAudioStateChanged);
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    if (widget.audioPath == null || widget.audioPath!.isEmpty) return;
    if (!_audioToggleService.isPlayable(widget.featureKey, widget.cardId)) return;

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
    final isEnabled =
        _audioToggleService.isPlayable(widget.featureKey, widget.cardId);
    final isPlaying = widget.audioPath != null && widget.audioPath!.isNotEmpty
        ? _audioPlayerService.isPlayingAudio(widget.audioPath!)
        : false;

    return InkWell(
      onTap: _togglePlayStop,
      splashColor: Colors.transparent,
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
            child: Stack(
              children: [
                Center(
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
                Positioned(
                  top: 6,
                  right: 6,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _audioToggleService.toggleCard(
                        widget.featureKey,
                        widget.cardId,
                      ),
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Icon(
                          isEnabled ? Icons.volume_up : Icons.volume_off,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
