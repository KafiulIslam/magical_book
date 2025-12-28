import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/bangla_category.dart';
import '../widgets/bangla_category_card.dart';

class BanglaPage extends StatelessWidget {
  const BanglaPage({super.key});

  static final List<BanglaCategory> _categories = [
    BanglaCategory(
      title: 'বর্ণমালা',
      subtitle: 'Alphabet',
      icon: Icons.abc,
      color: AppColors.primary,
    ),
    BanglaCategory(
      title: 'ছড়া',
      subtitle: 'Rhymes',
      icon: Icons.music_note,
      color: AppColors.action,
    ),
    BanglaCategory(
      title: 'ফলের নাম',
      subtitle: 'Fruit Names',
      icon: Icons.apple,
      color: AppColors.success,
    ),
    BanglaCategory(
      title: 'ফুলের নাম',
      subtitle: 'Flower Names',
      icon: Icons.local_florist,
      color: AppColors.reward,
    ),
    BanglaCategory(
      title: 'রিতুর নাম',
      subtitle: 'Season Names',
      icon: Icons.wb_sunny,
      color: AppColors.info,
    ),
    BanglaCategory(
      title: 'মাসের নাম',
      subtitle: 'Month Names',
      icon: Icons.calendar_month,
      color: AppColors.primary,
    ),
    BanglaCategory(
      title: 'দিনের নাম',
      subtitle: 'Day Names',
      icon: Icons.today,
      color: AppColors.action,
    ),
  ];

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: _getChildAspectRatio(context),
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return BanglaCategoryCard(category: category);
            },
          ),
        ),
      ),
    );
  }
}


