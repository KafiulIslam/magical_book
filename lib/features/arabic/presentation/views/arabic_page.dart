import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:magical_book/core/constants/asset_path.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/arabic_constant.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/arabic_category_card.dart';

class ArabicPage extends StatelessWidget {
  const ArabicPage({super.key});

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
          'عربي',
          style: ArabicTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: _getChildAspectRatio(context),
          ),
          itemCount: ArabicConstants.arabicCategories.length,
          itemBuilder: (context, index) {
            final category = ArabicConstants.arabicCategories[index];
            if (index == 0) {
              return _buildFirstCard(context);
            } else if (index == 3) {
              return _buildHistoryCard(context);
            } else {
              return ArabicCategoryCard(category: category);
            }
          },
        ),
      ),
    );
  }

  Widget _buildFirstCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          context.push(Routes.arabicAlphabet);
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withOpacity(0.1),
                AppColors.primary.withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    'ابت',
                    style: ArabicTypo.headline3.copyWith(fontSize: 28.sp),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'আরবি বর্নমালা',
                  style: BanglaTypo.headline1.copyWith(fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Arabic Alphabet',
                  style: EnglishTypo.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          context.push(Routes.arabicHistory);
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.reward.withOpacity(0.1),
                AppColors.reward.withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.reward.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AssetPath.history,
                    color: AppColors.reward,
                    height: 44.h,
                    width: 44.w,
                  ),
                ),
                const Gap(16),
                Text(
                  'ইসলামিক ইতিহাস',
                  style: BanglaTypo.headline1.copyWith(fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Islamic History',
                  style: EnglishTypo.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
