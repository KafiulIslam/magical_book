import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/chora_card.dart';

class ChoraScreen extends StatelessWidget {
  const ChoraScreen({super.key});

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) {
      return 2; // Large tablets/desktop
    } else if (width > 600) {
      return 2; // Tablets
    } else {
      return 1; // Mobile phones - single column for better readability
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'বাংলা ছড়া',
          style: BanglaTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: BanglaConstants.banglaChora.length,
          separatorBuilder: (_, index) => const Gap(16),
          itemBuilder: (context, index) {
            final chora = BanglaConstants.banglaChora[index];
            return ChoraCard(chora: chora, index: index);
          },
        ),
      ),
    );
  }
}
