import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Common widget for alphabet/letter cards (large text-only)
/// Used by: BornoCard, EnglishAlphabetCard
class CommonAlphabetCard extends StatelessWidget {
  final String letter;
  final String? fontFamily;
  final List<List<Color>> colorPalette;

  const CommonAlphabetCard({
    super.key,
    required this.letter,
    this.fontFamily,
    required this.colorPalette,
  });

  List<Color> _getCardColors(int index) {
    return colorPalette[index % colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(letter.hashCode);

    return Container(
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
      child: InkWell(
        onTap: () {

        },
        borderRadius: BorderRadius.circular(24),
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
              letter,
              style: TextStyle(
                fontFamily: fontFamily,
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
        ),
      ),
    );
  }
}

