import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'স্বরবর্ণ (Vowels)',
                style: BanglaTypo.headline2.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Shoroborno - Learn Bangla Vowels',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: BanglaConstants.banglaShorobornos.length,
                  itemBuilder: (context, index) {
                    final shoroborno = BanglaConstants.banglaShorobornos[index];
                    return _ShorobornoCard(shoroborno: shoroborno);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShorobornoCard extends StatelessWidget {
  final String shoroborno;

  const _ShorobornoCard({
    required this.shoroborno,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.15),
              AppColors.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: Center(
          child: Text(
            shoroborno,
            style: const TextStyle(
              fontFamily: 'Kalpurush',
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

