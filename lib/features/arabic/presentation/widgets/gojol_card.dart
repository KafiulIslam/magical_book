import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magical_book/core/theme/app_theme.dart';
import '../../../math/model/multiplication_model.dart';

 class GojolCard extends StatelessWidget {
  final MultiplicationModel item;
  final int index;
  final TextStyle textStyle;
  final TextStyle subtitleStyle;
  final double titleFontSize;
  final double subtitleFontSize;
  final List<List<Color>> colorPalette;
  final IconData errorIcon;
  final VoidCallback? onTap;

  const GojolCard(
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

  List<Color> _getCardColors(int index) {
    return colorPalette[index % colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(index);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: cardColors,
          ),
        ),
        child: Column(
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
                  item.image,
                  fit: BoxFit.cover,
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
            // Title and Subtitle

            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Center(
                  child: Text(
                    item.subTitle,
                    style: subtitleStyle.copyWith(
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
      ),
    );
  }
}
