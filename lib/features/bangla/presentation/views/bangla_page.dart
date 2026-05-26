import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/services/ad_preload_service.dart';
import '../../../../core/widgets/home_tab_body.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/router/routes.dart';
import '../widgets/bangla_category_card.dart';

class BanglaPage extends StatelessWidget {
  const BanglaPage({super.key});

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
          'বাংলা',
          style: BanglaTypo.headline1.copyWith(fontSize: 24.sp),
        ),
      ),
      body: HomeTabBody(
        bannerSlotId: AdPreloadService.bangla,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: _getChildAspectRatio(context),
          ),
          itemCount: BanglaConstants.categories.length,
          itemBuilder: (context, index) {
            final category = BanglaConstants.categories[index];
            if (index == 0) {
              return _buildFirstCard(context);
            } else {
              return BanglaCategoryCard(category: category);
            }
          },
        ),
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
          context.push(Routes.bornoMala);
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
                  child: Text('অ/ক',
                      style: BanglaTypo.headline1.copyWith(fontSize: 20.sp)),
                ),
                const SizedBox(height: 16),
                Text(
                  'বর্ণমালা',
                  style: BanglaTypo.headline1.copyWith(fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Alphabet',
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
