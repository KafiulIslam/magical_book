import 'package:flutter/material.dart';
import '../../features/math/model/multiplication_model.dart';

/// Common widget for multiplication table cards (image + title + subtitle)
class CommonMultiplicationCard extends StatelessWidget {
  final MultiplicationModel item;
  final int index;
  final TextStyle textStyle;
  final TextStyle subtitleStyle;
  final double titleFontSize;
  final double subtitleFontSize;
  final List<List<Color>> colorPalette;
  final IconData errorIcon;
  final BoxFit imageFit;

  const CommonMultiplicationCard({
    super.key,
    required this.item,
    required this.index,
    required this.textStyle,
    required this.subtitleStyle,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.colorPalette,
    required this.errorIcon,
    this.imageFit = BoxFit.contain,
  });

  List<Color> _getCardColors(int index) {
    return colorPalette[index % colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(index);

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
          onTap: () {
            // TODO: Navigate to multiplication table detail or play audio
          },
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
                color: Colors.white.withOpacity(0.3),
                width: 2,
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
                          item.image,
                          fit: imageFit,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              errorIcon,
                              size: 60,
                              color: Colors.white.withOpacity(0.7),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // Title and Subtitle
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          style: textStyle.copyWith(
                            fontSize: titleFontSize,
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subTitle,
                          style: subtitleStyle.copyWith(
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.w600,
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
                      ],
                    ),
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
