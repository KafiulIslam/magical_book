import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/common_text_card.dart';
import '../../../../core/widgets/card_color_palettes.dart';

class BanglaDayScreen extends StatelessWidget {
  const BanglaDayScreen({super.key});

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) {
      return 4; // Large tablets/desktop
    } else if (width > 600) {
      return 3; // Tablets
    } else {
      return 2; // Mobile phones
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'দিনের নাম',
          style: BanglaTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2, // Wider cards for text-only content
          ),
          itemCount: BanglaConstants.banglaDin.length,
          itemBuilder: (context, index) {
            final din = BanglaConstants.banglaDin[index];
            return CommonTextCard(
              item: din,
              index: index,
              textStyle: BanglaTypo.headline1,
              fontSize: 28.sp,
              colorPalette: CardColorPalettes.days7,
            );
          },
        ),
      ),
    );
  }
}

