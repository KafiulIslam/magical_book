import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BanglaPage extends StatelessWidget {
  const BanglaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'বাংলা',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            const Text(
              'বাংলা শিখুন',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Learn Bangla',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

