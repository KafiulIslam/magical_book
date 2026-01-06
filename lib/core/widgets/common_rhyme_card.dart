import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../theme/app_typography.dart';

/// Common widget for horizontal rhyme cards
/// Used by: ChoraCard, EnglishRhymesCard
class CommonRhymeCard extends StatelessWidget {
  final String title;
  final String image;
  final int index;
  final TextStyle textStyle;
  final List<List<Color>> colorPalette;
  final double imageWidth;
  final double imageHeight;

  const CommonRhymeCard({
    super.key,
    required this.title,
    required this.image,
    required this.index,
    required this.textStyle,
    required this.colorPalette,
    this.imageWidth = 120,
    this.imageHeight = 125,
  });

  List<Color> _getCardColors(int index) {
    return colorPalette[index % colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(index);

    return InkWell(
      onTap: () {
        // TODO: Navigate to rhyme detail screen or play audio
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: cardColors,
          ),
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                width: imageWidth.w,
                height: imageHeight.h,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.music_note,
                    size: 50.sp,
                    color: Colors.white.withOpacity(0.7),
                  );
                },
              ),
            ),

            // Title and play button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textStyle.copyWith(
                        fontSize: 20.sp,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_filled,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          const Gap(6),
                          Text(
                            'Play',
                            style: EnglishTypo.headline3
                                .copyWith(color: Colors.white, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
