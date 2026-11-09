import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppUpdateDialog extends StatelessWidget {
  const AppUpdateDialog({
    super.key,
    required this.versionLabel,
    required this.installedVersion,
    required this.onSkip,
    required this.onUpdate,
  });

  final String versionLabel;
  final String installedVersion;
  final VoidCallback onSkip;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text('New version available'),
      content: Text(
        'Version $versionLabel is available. You are using $installedVersion.',
      ),
      actions: [
        TextButton(
          onPressed: onSkip,
          child: const Text('Skip'),
        ),
        FilledButton(
          onPressed: onUpdate,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
          ),
          child: const Text('Update'),
        ),
      ],
    );
  }
}
