import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../models/bangla_mas_model.dart';

class MasCard extends StatelessWidget {
  final BanglaMasModel mas;
  final int index;

  const MasCard({
    required this.mas,
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
      [AppColors.action, AppColors.primary],
      [AppColors.success, AppColors.reward],
      [AppColors.reward, AppColors.info],
      [AppColors.info, AppColors.action],
      [AppColors.primary, AppColors.success],
      [AppColors.action, AppColors.success],
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
            // TODO: Play audio or show month details
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  mas.name,
                  style: BanglaTypo.headline1.copyWith(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
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
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

