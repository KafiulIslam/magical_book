import 'package:flutter/material.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../model/multiplication_model.dart';

/// Common widget for multiplication table cards (image + title + subtitle)
class MultiplicationCard extends StatefulWidget {
  final MultiplicationModel item;
  final int index;
  final TextStyle textStyle;
  final TextStyle subtitleStyle;
  final double titleFontSize;
  final double subtitleFontSize;
  final List<List<Color>> colorPalette;
  final IconData errorIcon;
  final VoidCallback? onTap;

  const MultiplicationCard(
      {super.key,
      required this.item,
      required this.index,
      required this.textStyle,
      required this.subtitleStyle,
      required this.titleFontSize,
      required this.subtitleFontSize,
      required this.colorPalette,
      required this.errorIcon,
      this.onTap});

  @override
  State<MultiplicationCard> createState() => _MultiplicationCardState();
}

class _MultiplicationCardState extends State<MultiplicationCard> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  String get _itemId => 'multiplication_${widget.item.id}';

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  void _onCompleted() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _audioPlayerService.addStateChangeHandler(_onStateChanged);
    _audioPlayerService.addCompletionHandler(_onCompleted);
  }

  @override
  void dispose() {
    _audioPlayerService.removeStateChangeHandler(_onStateChanged);
    _audioPlayerService.removeCompletionHandler(_onCompleted);
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    if (_audioPlayerService.isPlayingItem(_itemId)) {
      await _audioPlayerService.stop();
    } else {
      await _audioPlayerService.play(widget.item.audio, itemId: _itemId);
    }
    if (mounted) setState(() {});
  }

  List<Color> _getCardColors(int index) {
    return widget.colorPalette[index % widget.colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(widget.index);
    final isPlaying = _audioPlayerService.isPlayingItem(_itemId);

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
                // Subtitle
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Center(
                      child: Text(
                        widget.item.subTitle,
                        style: widget.subtitleStyle.copyWith(
                          fontSize: widget.subtitleFontSize,
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

                // Flexible(
                //   flex: 1,
                //   child: Padding(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           item.title,
                //           style: textStyle.copyWith(
                //             fontSize: titleFontSize,
                //             fontWeight: FontWeight.w900,
                //             color: Colors.white,
                //             shadows: const [
                //               Shadow(
                //                 color: Colors.black26,
                //                 blurRadius: 6,
                //                 offset: Offset(2, 2),
                //               ),
                //             ],
                //           ),
                //           textAlign: TextAlign.center,
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //         const SizedBox(height: 4),
                //         Text(
                //           item.subTitle,
                //           style: subtitleStyle.copyWith(
                //             fontSize: subtitleFontSize,
                //             fontWeight: FontWeight.w600,
                //             color: Colors.white.withOpacity(0.9),
                //             shadows: const [
                //               Shadow(
                //                 color: Colors.black26,
                //                 blurRadius: 4,
                //                 offset: Offset(1, 1),
                //               ),
                //             ],
                //           ),
                //           textAlign: TextAlign.center,
                //           maxLines: 2,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
            // Play/Stop button (top-right)
            Positioned(
              top: 4,
              right: 4,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _togglePlayStop,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.35),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      isPlaying ? Icons.stop : Icons.play_arrow,
                      color: Colors.white,
                      size: 22,
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
