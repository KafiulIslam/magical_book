import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magical_book/core/services/audio_player_service.dart';
import 'package:magical_book/core/theme/app_typography.dart';
import 'package:magical_book/features/arabic/model/arabic_alphabet_model.dart';

/// Widget for Arabic alphabet cards with audio playback
class ArabicAlphabetCard extends StatefulWidget {
  final ArabicAlphabetModel letterModel;
  final List<List<Color>> colorPalette;
  final AudioPlayerService audioPlayerService;

  const ArabicAlphabetCard({
    super.key,
    required this.letterModel,
    required this.colorPalette,
    required this.audioPlayerService,
  });

  @override
  State<ArabicAlphabetCard> createState() => _ArabicAlphabetCardState();
}

class _ArabicAlphabetCardState extends State<ArabicAlphabetCard> {
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
    final itemId = widget.letterModel.id.toString();
    if (widget.audioPlayerService.isPlayingItem(itemId)) {
      await widget.audioPlayerService.stop();
    } else {
      await widget.audioPlayerService.play(
        widget.letterModel.audioPath,
        itemId: itemId,
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
    final cardColors = _getCardColors(widget.letterModel.letter.hashCode);

    return InkWell(
      splashColor: Colors.transparent,
      onTap: _togglePlayStop,
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
            widget.letterModel.letter,
            style: ArabicTypo.headline1.copyWith(
              fontSize: 72.sp,
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
    );
  }
}
