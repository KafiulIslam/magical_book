import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BornoCard extends StatelessWidget {
  final String shoroborno;

  const BornoCard({
    required this.shoroborno,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.15),
              AppColors.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: Center(
          child: Text(
            shoroborno,
            style: const TextStyle(
              fontFamily: 'Kalpurush',
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.2,
              letterSpacing: 0,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}