import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/english_constant.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/common_image_text_card.dart';
import '../../../../core/widgets/card_color_palettes.dart';

class EnglishBodyPartScreen extends StatelessWidget {
  const EnglishBodyPartScreen({super.key});

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
          'Body Parts',
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
            childAspectRatio: 0.72, // Slightly taller cards to accommodate text
          ),
          itemCount: EnglishConstants.humanBody.length,
          itemBuilder: (context, index) {
            final bodyPart = EnglishConstants.humanBody[index];
            return CommonImageTextCard(
              item: bodyPart,
              index: index,
              textStyle: EnglishTypo.headline2,
              fontSize: 20.sp,
              colorPalette: CardColorPalettes.bodyParts,
              errorIcon: Icons.accessibility,
              imageFit: BoxFit.fill,
              useFlexibleForText: false,
            );
          },
        ),
      ),
    );
  }
}

