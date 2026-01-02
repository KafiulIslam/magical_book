import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/ritu_card.dart';

class BanglaSeasonScreen extends StatelessWidget {
  const BanglaSeasonScreen({super.key});

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
          'রিতুর নাম',
          style: BanglaTypo.headline1.copyWith(fontSize: 24),
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
          itemCount: BanglaConstants.banglaRitu.length,
          itemBuilder: (context, index) {
            final ritu = BanglaConstants.banglaRitu[index];
            return RituCard(ritu: ritu, index: index);
          },
        ),
      ),
    );
  }
}

