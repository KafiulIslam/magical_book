import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/english_constant.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/english_rhymes_card.dart';

class EnglishRhymesScreen extends StatelessWidget {
  const EnglishRhymesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'English Rhymes',
          style: EnglishTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: EnglishConstants.englishRhymes.length,
          separatorBuilder: (_, index) => const Gap(16),
          itemBuilder: (context, index) {
            final rhyme = EnglishConstants.englishRhymes[index];
            return EnglishRhymesCard(rhyme: rhyme, index: index);
          },
        ),
      ),
    );
  }
}
