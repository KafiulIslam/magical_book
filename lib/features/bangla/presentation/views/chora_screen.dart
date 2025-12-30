import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:magical_book/features/bangla/presentation/widgets/borno_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/theme/app_typography.dart';

class ChoraScreen extends StatelessWidget {
  const ChoraScreen({super.key});

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
          'বাংলা ছড়া',
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
            _buildHeader(
              title: 'বাংলা স্বরবর্ণ',
              subtitle: 'Shoroborno - Learn Bangla Vowels',
              gradientColors: [AppColors.primary, AppColors.info],
              emoji: '✨',
            ),
            const Gap(16),
            _buildLetterGrid(
              context,
              BanglaConstants.banglaShorobornos,
            ),
            const Gap(32),
            // Byanjonborno Section
            _buildHeader(
              title: 'বাংলা ব্যঞ্জনবর্ণ',
              subtitle: 'Byanjonborno - Learn Bangla Consonants',
              gradientColors: [AppColors.action, AppColors.reward],
              emoji: '🎯',
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
            style: BanglaTypo.headline2.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                const Shadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          const Gap(  4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              shadows: [
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
        return BornoCard(shoroborno: letter);
      },
    );
  }
}
