import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/mas_card.dart';

class BanglaMonthScreen extends StatelessWidget {
  const BanglaMonthScreen({super.key});

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
          'মাসের নাম',
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
            childAspectRatio: 1.2, // Wider cards for text-only content
          ),
          itemCount: BanglaConstants.banglaMas.length,
          itemBuilder: (context, index) {
            final mas = BanglaConstants.banglaMas[index];
            return MasCard(mas: mas, index: index);
          },
        ),
      ),
    );
  }
}
