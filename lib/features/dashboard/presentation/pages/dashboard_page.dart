import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/routes.dart';

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
    'বাংলা',
    'English',
    'Math',
    'عربي',
  ];

  static final List<IconData> _icons = [
    Icons.menu_book,
    Icons.language,
    Icons.calculate,
    Icons.text_fields,
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
      appBar: AppBar(
        title: Text(
          currentTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
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
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
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
