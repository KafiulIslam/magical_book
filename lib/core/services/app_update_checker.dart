import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_update_dialog.dart';

/// Asks Play whether a newer build is published, then shows Skip / Update.
class AppUpdateChecker {
  AppUpdateChecker._();

  static bool _promptedThisLaunch = false;

  static Future<void> promptIfUpdateAvailable(BuildContext context) async {
    if (_promptedThisLaunch || kIsWeb || !Platform.isAndroid) return;
    _promptedThisLaunch = true;

    try {
      final update = await InAppUpdate.checkForUpdate();
      if (update.updateAvailability != UpdateAvailability.updateAvailable) {
        return;
      }

      final packageInfo = await PackageInfo.fromPlatform();
      final availableCode = update.availableVersionCode;
      final installedCode = int.tryParse(packageInfo.buildNumber);
      if (availableCode != null &&
          installedCode != null &&
          availableCode <= installedCode) {
        return;
      }

      final storeVersion = await _storeVersionName(packageInfo.packageName);
      final versionLabel = storeVersion ??
          (availableCode != null ? 'code $availableCode' : 'a newer version');

      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AppUpdateDialog(
            versionLabel: versionLabel,
            installedVersion: packageInfo.version,
            onSkip: () => Navigator.of(dialogContext).pop(),
            onUpdate: () async {
              Navigator.of(dialogContext).pop();
              await _openPlayStore(packageInfo.packageName);
            },
          );
        },
      );
    } catch (error) {
      if (kDebugMode) {
        debugPrint('Update check skipped: $error');
      }
    }
  }

  static Future<void> _openPlayStore(String packageName) async {
    final market = Uri.parse('market://details?id=$packageName');
    final web = Uri.parse(
      'https://play.google.com/store/apps/details?id=$packageName',
    );
    if (await canLaunchUrl(market) &&
        await launchUrl(market, mode: LaunchMode.externalApplication)) {
      return;
    }
    await launchUrl(web, mode: LaunchMode.externalApplication);
  }

  /// Play's update API returns a version code. The store page sometimes
  /// includes the version name, which is what we prefer to show.
  static Future<String?> _storeVersionName(String packageName) async {
    final client = HttpClient();
    try {
      client.connectionTimeout = const Duration(seconds: 5);
      final request = await client.getUrl(
        Uri.parse(
          'https://play.google.com/store/apps/details?id=$packageName&hl=en&gl=us',
        ),
      );
      request.headers.set(
        HttpHeaders.userAgentHeader,
        'Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36 '
        '(KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
      );
      final response = await request.close().timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) return null;
      final bytes = await response.fold<List<int>>(
        <int>[],
        (previous, chunk) => previous..addAll(chunk),
      );
      final body = utf8.decode(bytes, allowMalformed: true);
      final match = RegExp(
        r'\[\[\["(\d+\.\d+(?:\.\d+)?)"\]\]',
      ).firstMatch(body);
      return match?.group(1);
    } catch (_) {
      return null;
    } finally {
      client.close(force: true);
    }
  }
}
