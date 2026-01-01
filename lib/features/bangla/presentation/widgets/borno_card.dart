import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class BornoCard extends StatelessWidget {
  final String shoroborno;

  const BornoCard({
    super.key,
    required this.shoroborno,
  });

  /// Get vibrant colors for child-friendly design
  List<Color> _getCardColors(int index) {
    final colors = [
      [AppColors.primary, AppColors.info],
      [AppColors.action, AppColors.reward],
      [AppColors.success, AppColors.primary],
      [AppColors.reward, AppColors.action],
      [AppColors.info, AppColors.success],
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors(shoroborno.hashCode);

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
          // TODO: Add sound or interaction for children
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
              shoroborno,
              style: TextStyle(
                fontFamily: 'Kalpurush',
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
