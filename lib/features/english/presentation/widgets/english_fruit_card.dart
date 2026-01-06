import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magical_book/features/bangla/models/common_content_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class EnglishFruitCard extends StatelessWidget {
  final CommonContentModel fruit;
  final int index;

  const EnglishFruitCard({
    super.key,
    required this.fruit,
    required this.index,
  });

  List<Color> _getCardColors(int index) {
    final colors = [
      [AppColors.success, AppColors.primary],
      [AppColors.reward, AppColors.action],
      [AppColors.primary, AppColors.info],
      [AppColors.action, AppColors.success],
      [AppColors.info, AppColors.reward],
      [AppColors.success, AppColors.action],
      [AppColors.primary, AppColors.reward],
      [AppColors.action, AppColors.primary],
    ];
    return colors[index % colors.length];
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
            // TODO: Play audio or show fruit details
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
                // Fruit Image
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
                          fruit.image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.apple,
                              size: 60,
                              color: Colors.white.withOpacity(0.7),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // Fruit Name
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Center(
                      child: Text(
                        fruit.title,
                        style: EnglishTypo.headline2.copyWith(
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
