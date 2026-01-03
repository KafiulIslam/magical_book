import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../models/bangla_chora_model.dart';

class ChoraCard extends StatelessWidget {
  final BanglaChoraModel chora;
  final int index;

  const ChoraCard({
    required this.chora,
    required this.index,
  });

  List<Color> _getCardColors(int index) {
    final colors = [
      [AppColors.primary, AppColors.info],
      [AppColors.action, AppColors.reward],
      [AppColors.success, AppColors.primary],
      [AppColors.reward, AppColors.action],
      [AppColors.info, AppColors.success],
      [AppColors.primary, AppColors.action],
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(index);

    return InkWell(
      onTap: () {
        // TODO: Navigate to chora detail screen or play audio
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
            Container(
              width: 120.w,
              height: 110.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Colors.white.withOpacity(0.2),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.asset(
                  chora.image,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.music_note,
                      size: 50,
                      color: Colors.white.withOpacity(0.7),
                    );
                  },
                ),
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
                      chora.title,
                      style: BanglaTypo.headline3.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [
                          const Shadow(
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
                      child:   Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.play_circle_filled,
                            color: Colors.white,
                            size: 24,
                          ),
                          const Gap(6),
                          Text(
                            'Play',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
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
