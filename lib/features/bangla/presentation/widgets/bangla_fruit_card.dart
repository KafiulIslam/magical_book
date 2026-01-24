import 'package:flutter/material.dart';

import '../../../../core/services/audio_player_service.dart';
import '../../../../core/services/tts_service.dart';
import '../../models/common_content_model.dart';

/// Common widget for image + text cards
/// Used by: FolCard, FulCard, RituCard, EnglishFruitCard, EnglishFlowerCard,
///          EnglishAnimalCard, EnglishBirdCard, EnglishBodyPartCard
class BanglaFruitCard extends StatefulWidget {
  final CommonContentModel item;
  final int index;
  final TextStyle textStyle;
  final double fontSize;
  final List<List<Color>> colorPalette;
  final IconData errorIcon;
  final BoxFit imageFit;
  final bool useFlexibleForText;
  final AudioPlayerService? audioPlayerService; // Optional audio service
  final TtsService? ttsService; // Optional TTS service

  const BanglaFruitCard({
    super.key,
    required this.item,
    required this.index,
    required this.textStyle,
    required this.fontSize,
    required this.colorPalette,
    required this.errorIcon,
    this.imageFit = BoxFit.contain,
    this.useFlexibleForText = true,
    this.audioPlayerService,
    this.ttsService,
  });

  @override
  State<BanglaFruitCard> createState() => _BanglaFruitCardState();
}

class _BanglaFruitCardState extends State<BanglaFruitCard> {
  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  void _onCompleted() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Register handlers for audio service
    if (widget.audioPlayerService != null) {
      widget.audioPlayerService!.addStateChangeHandler(_onStateChanged);
      widget.audioPlayerService!.addCompletionHandler(_onCompleted);
    }
    // Register handlers for TTS service
    if (widget.ttsService != null) {
      widget.ttsService!.addStateChangeHandler(_onStateChanged);
      widget.ttsService!.addCompletionHandler(_onCompleted);
    }
  }

  @override
  void dispose() {
    if (widget.audioPlayerService != null) {
      widget.audioPlayerService!.removeStateChangeHandler(_onStateChanged);
      widget.audioPlayerService!.removeCompletionHandler(_onCompleted);
    }
    if (widget.ttsService != null) {
      widget.ttsService!.removeStateChangeHandler(_onStateChanged);
      widget.ttsService!.removeCompletionHandler(_onCompleted);
    }
    super.dispose();
  }

  Future<void> _handleTap() async {
    // Priority 1: Pre-recorded audio
    if (widget.audioPlayerService != null && widget.item.audio.isNotEmpty) {
      final itemId = 'fruit_${widget.item.id}';
      if (widget.audioPlayerService!.isPlayingItem(itemId)) {
        await widget.audioPlayerService!.stop();
      } else {
        await widget.audioPlayerService!.play(
          widget.item.audio,
          itemId: itemId,
        );
      }
    } 
    // Priority 2: TTS
    else if (widget.ttsService != null) {
      if (widget.ttsService!.isSpeakingText(widget.item.title)) {
        await widget.ttsService!.stop();
      } else {
        await widget.ttsService!.speak(widget.item.title);
      }
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
    final isPlaying = (widget.audioPlayerService != null && 
                       widget.item.audio.isNotEmpty && 
                       widget.audioPlayerService!.isPlayingItem('fruit_${widget.item.id}')) ||
                      (widget.ttsService != null && 
                       widget.ttsService!.isSpeakingText(widget.item.title));

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
          onTap: _handleTap,
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
                color: isPlaying ? Colors.white : Colors.white.withOpacity(0.3),
                width: isPlaying ? 3 : 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          widget.item.image,
                          fit: widget.imageFit,
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
                  ),
                ),
                // Text
                if (widget.useFlexibleForText)
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Center(
                        child: Text(
                          widget.item.title,
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
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      widget.item.title,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
