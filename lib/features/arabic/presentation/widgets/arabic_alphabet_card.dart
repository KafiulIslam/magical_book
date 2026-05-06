import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magical_book/core/constants/audio_feature_keys.dart';
import 'package:magical_book/core/services/audio_player_service.dart';
import 'package:magical_book/core/services/audio_toggle_service.dart';
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
  final AudioToggleService _audioToggleService = AudioToggleService();

  String get _itemId => 'arabic_letter_${widget.letterModel.id}';

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
    _audioToggleService.initialize();
    _audioToggleService.addStateChangeHandler(_onStateChanged);
  }

  @override
  void dispose() {
    widget.audioPlayerService.removeStateChangeHandler(_onStateChanged);
    widget.audioPlayerService.removeCompletionHandler(_onCompleted);
    _audioToggleService.removeStateChangeHandler(_onStateChanged);
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    if (!_audioToggleService.isPlayable(
      AudioFeatureKeys.arabicAlphabet,
      _itemId,
    )) {
      return;
    }

    if (widget.audioPlayerService.isPlayingItem(_itemId)) {
      await widget.audioPlayerService.stop();
    } else {
      await widget.audioPlayerService.play(
        widget.letterModel.audioPath,
        itemId: _itemId,
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
    final isEnabled = _audioToggleService.isPlayable(
      AudioFeatureKeys.arabicAlphabet,
      _itemId,
    );
    final isPlaying = widget.audioPlayerService.isPlayingItem(_itemId);

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
            color: isPlaying ? Colors.white : Colors.white.withOpacity(0.3),
            width: isPlaying ? 3 : 2,
          ),
        ),
        child: Stack(
          children: [
            Center(
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
            Positioned(
              top: 6,
              right: 6,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _audioToggleService.toggleCard(
                    AudioFeatureKeys.arabicAlphabet,
                    _itemId,
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
      ),
    );
  }
}
