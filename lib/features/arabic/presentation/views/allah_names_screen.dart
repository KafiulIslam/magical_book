import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/arabic_constant.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../widgets/allah_name_card.dart';

class AllahNamesScreen extends StatefulWidget {
  const AllahNamesScreen({super.key});

  @override
  State<AllahNamesScreen> createState() => _AllahNamesScreenState();
}

class _AllahNamesScreenState extends State<AllahNamesScreen> {
  final TtsService _ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _ttsService.initialize();
    // Listen to TTS state changes to update UI
    _ttsService.setCompletionHandler(() {
      if (mounted) {
        setState(() {});
      }
    });
    _ttsService.setErrorHandler((msg) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'আল্লাহর ৯৯ নাম',
          style: BanglaTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(
              title: 'আসমাউল হুসনা',
              subtitle: 'The 99 Beautiful Names of Allah',
              gradientColors: [AppColors.reward, AppColors.primary],
              emoji: '✨',
            ),
            const Gap(16),
            // Names List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ArabicConstants.allahNames.length,
              itemBuilder: (context, index) {
                final name = ArabicConstants.allahNames[index];
                return AllahNameCard(
                  name: name,
                  index: index,
                  colorPalette: CardColorPalettes.alphabet,
                  ttsService: _ttsService,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required String emoji,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: BanglaTypo.headline2.copyWith(
              fontSize: 26.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: const [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          const Gap(4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: EnglishTypo.bodyLarge.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              shadows: const [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
