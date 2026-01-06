import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/english_constant.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/common_image_text_card.dart';
import '../../../../core/widgets/card_color_palettes.dart';

class EnglishFruitScreen extends StatelessWidget {
  const EnglishFruitScreen({super.key});

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
          'Fruits',
          style: EnglishTypo.headline1.copyWith(fontSize: 24.sp),
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
            childAspectRatio: 0.72, // Slightly taller cards to accommodate longer text
          ),
          itemCount: EnglishConstants.fruitsName.length,
          itemBuilder: (context, index) {
            final fruit = EnglishConstants.fruitsName[index];
            return CommonImageTextCard(
              item: fruit,
              index: index,
              textStyle: EnglishTypo.headline2,
              fontSize: 20.sp,
              colorPalette: CardColorPalettes.fruits,
              errorIcon: Icons.apple,
              imageFit: BoxFit.contain,
              useFlexibleForText: true,
            );
          },
        ),
      ),
    );
  }
}

