import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_typography.dart';

class DashboardPage extends StatelessWidget {
  final Widget child;

  const DashboardPage({
    super.key,
    required this.child,
  });

  static final List<String> _routes = [
    Routes.bangla,
    Routes.english,
    Routes.math,
    Routes.arabic,
  ];

  static final List<String> _titles = [
    // 'বাংলা',
    // 'English',
    // 'Math',
    // 'عربي',
    'Bangla',
    'English',
    'Math',
    'Arabic',
  ];

  static final List<IconData> _icons = [
    Icons.menu_book,
    Icons.font_download_outlined,
    Icons.calculate,
    Icons.auto_stories_outlined,
  ];

  static int _getCurrentIndex(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final index = _routes.indexOf(currentPath);
    return index >= 0 ? index : 0;
  }

  static String _getCurrentTitle(BuildContext context) {
    final index = _getCurrentIndex(context);
    return _titles[index];
  }

  static void _onItemTapped(BuildContext context, int index) {
    if (index < 0 || index >= _routes.length) return;
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);
    final currentTitle = _getCurrentTitle(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onItemTapped(context, index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: EnglishTypo.headline3.copyWith(fontSize: 12.sp),
          unselectedLabelStyle: EnglishTypo.headline4.copyWith(fontSize: 12.sp),
          iconSize: 20.sp,
          backgroundColor: AppColors.surface,
          elevation: 0,
          items: List.generate(
            _routes.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(_icons[index]),
              label: _titles[index],
            ),
          ),
        ),
      ),
    );
  }
}
