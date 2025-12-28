import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

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
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: _getChildAspectRatio(context),
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return _BanglaCategoryCard(category: category);
            },
          ),
        ),
      ),
    );
  }
}

class BanglaCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const BanglaCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class _BanglaCategoryCard extends StatelessWidget {
  final BanglaCategory category;

  const _BanglaCategoryCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to category detail page
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                category.color.withOpacity(0.1),
                category.color.withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    category.icon,
                    size: 40,
                    color: category.color,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  category.title,
                  style: const TextStyle(
                    fontFamily: 'Kalpurush',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  category.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
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
