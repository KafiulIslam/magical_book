import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/english_constant.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/services/ad_preload_service.dart';
import '../../../../core/widgets/home_tab_body.dart';
import '../widgets/english_category_card.dart';

class EnglishPage extends StatelessWidget {
  const EnglishPage({super.key});

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

  double _getChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) {
      return 1.0; // Square cards for large screens
    } else if (width > 600) {
      return 0.95; // Slightly taller for tablets
    } else {
      return 0.85; // Taller cards for mobile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'English',
          style: EnglishTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: HomeTabBody(
        bannerSlotId: AdPreloadService.english,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: _getChildAspectRatio(context),
          ),
          itemCount: EnglishConstants.englishCategories.length,
          itemBuilder: (context, index) {
            final category = EnglishConstants.englishCategories[index];
            return EnglishCategoryCard(category: category);
          },
        ),
        ),
      ),
    );
  }
}
