import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/services/ad_preload_service.dart';
import '../../../../core/services/admob_service.dart';
import '../../../../core/services/interstitial_ad_service.dart';
import '../../../../core/theme/app_typography.dart';

class DashboardPage extends StatefulWidget {
  final Widget child;

  const DashboardPage({
    super.key,
    required this.child,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    AdMobService.instance.initialize();
    AdPreloadService.instance.warmAll();
    InterstitialAdService.instance.preload();
  }

  static final List<String> _routes = [
    Routes.bangla,
    Routes.english,
    Routes.math,
    Routes.arabic,
  ];

  static final List<String> _titles = [
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
    for (int i = 0; i < _routes.length; i++) {
      if (currentPath == _routes[i] ||
          currentPath.startsWith('${_routes[i]}/')) {
        return i;
      }
    }
    return 0;
  }

  static void _onItemTapped(BuildContext context, int index) {
    if (index < 0 || index >= _routes.length) return;
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);

    return Scaffold(
      body: widget.child,
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
