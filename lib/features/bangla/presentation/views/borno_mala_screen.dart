import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:magical_book/features/bangla/presentation/widgets/shoroborno_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/theme/app_typography.dart';

class BornoMalaScreen extends StatelessWidget {
  const BornoMalaScreen({super.key});

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) {
      return 6; // Large tablets/desktop
    } else if (width > 600) {
      return 5; // Tablets
    } else {
      return 4; // Mobile phones
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'বর্ণমালা',
          style: BanglaTypo.headline1.copyWith(fontSize: 24),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shoroborno Section
            Text(
              'বাংলা স্বরবর্ণ (Vowels)',
              style: BanglaTypo.headline2.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            const Text(
              'Shoroborno - Learn Bangla Vowels',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(16),
            _buildLetterGrid(
              context,
              BanglaConstants.banglaShorobornos,
            ),
            const Gap(32),
            // Byanjonborno Section
            Text(
              'বাংলা ব্যঞ্জনবর্ণ (Consonants)',
              style: BanglaTypo.headline2.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            const Text(
              'Byanjonborno - Learn Bangla Consonants',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(16),
            _buildLetterGrid(
              context,
              BanglaConstants.banglaByanjonbornos,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLetterGrid(BuildContext context, List<String> letters) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.85,
      ),
      itemCount: letters.length,
      itemBuilder: (context, index) {
        final letter = letters[index];
        return BornoCard(shoroborno: letter);
      },
    );
  }
}


