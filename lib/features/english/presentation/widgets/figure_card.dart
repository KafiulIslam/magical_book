import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/figure_model.dart';

/// Common widget for figure/shape cards (icon + text)
/// Used by: EnglishFigureScreen
class FigureCard extends StatelessWidget {
  final FigureModel figure;
  final int index;
  final TextStyle textStyle;
  final double fontSize;
  final List<List<Color>> colorPalette;

  const FigureCard({
    super.key,
    required this.figure,
    required this.index,
    required this.textStyle,
    required this.fontSize,
    required this.colorPalette,
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
            // TODO: Play audio or show figure details
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
                // Icon
                Expanded(
                  flex: 3,
                  child: Icon(
                    figure.image,
                    size: 100.sp,
                    color: Colors.white,
                  ),
                ),
                // Figure Name
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Center(
                      child: Text(
                        figure.title,
                        style: textStyle.copyWith(
                          fontSize: fontSize,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

