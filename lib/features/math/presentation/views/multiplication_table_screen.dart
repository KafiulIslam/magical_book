import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/math_constant.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/multiplication_card.dart';
import '../../../../core/widgets/card_color_palettes.dart';

class MultiplicationTableScreen extends StatelessWidget {
  const MultiplicationTableScreen({super.key});

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
          'নামতা',
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
            childAspectRatio: 0.75, // Taller cards for images
          ),
          itemCount: MathConstants.multiplicationList.length,
          itemBuilder: (context, index) {
            final multiplication = MathConstants.multiplicationList[index];
            return MultiplicationCard(
              item: multiplication,
              index: index,
              textStyle: BanglaTypo.headline2,
              subtitleStyle: BanglaTypo.bodyLarge,
              titleFontSize: 28.sp,
              subtitleFontSize: 20.sp,
              colorPalette: CardColorPalettes.fruits,
              errorIcon: Icons.table_chart,
            );
          },
        ),
      ),
    );
  }
}