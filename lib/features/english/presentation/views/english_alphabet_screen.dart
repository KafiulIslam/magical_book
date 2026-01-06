import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/english_constant.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/common_alphabet_card.dart';
import '../../../../core/widgets/card_color_palettes.dart';

class EnglishAlphabetScreen extends StatelessWidget {
  const EnglishAlphabetScreen({super.key});

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) {
      return 5; // Large tablets/desktop - fewer columns for larger cards
    } else if (width > 600) {
      return 4; // Tablets - fewer columns for larger cards
    } else {
      return 3; // Mobile phones - fewer columns for larger cards
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alphabet',
          style: EnglishTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alphabet Section
            _buildHeader(
              title: 'English Alphabet',
              subtitle: 'A to Z - Learn English Alphabet',
              gradientColors: [AppColors.primary, AppColors.info],
              emoji: '✨',
            ),
            const Gap(16),
            _buildLetterGrid(
              context,
              EnglishConstants.englishAlphabet,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required String emoji,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: EnglishTypo.headline2.copyWith(
              fontSize: 26.sp,
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
          ),
          const Gap(4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: EnglishTypo.bodyLarge.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              shadows: const [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLetterGrid(BuildContext context, List<String> letters) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9, // Slightly wider for better visibility
      ),
      itemCount: letters.length,
      itemBuilder: (context, index) {
        final letter = letters[index];
        return CommonAlphabetCard(
          letter: letter,
          colorPalette: CardColorPalettes.alphabet,
        );
      },
    );
  }
}
