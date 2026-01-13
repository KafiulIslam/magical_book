import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/arabic_constant.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../widgets/gojol_card.dart';

class ArabicGojolScreen extends StatefulWidget {
  const ArabicGojolScreen({super.key});

  @override
  State<ArabicGojolScreen> createState() => _ArabicGojolScreenState();
}

class _ArabicGojolScreenState extends State<ArabicGojolScreen> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  @override
  void initState() {
    super.initState();
    // Listen to audio completion to update UI
    _audioPlayerService.setCompletionHandler(() {
      if (mounted) {
        setState(() {});
      }
    });
    // Listen to state changes (play/stop) to update UI
    _audioPlayerService.addStateChangeHandler(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ইসলামিক গজল',
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
              title: 'ইসলামিক গজল',
              subtitle: 'Islamic Ghazal - Spiritual Songs',
              gradientColors: [AppColors.success, AppColors.primary],
              emoji: '🎵',
            ),
            const Gap(16),
            // Gojol Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75, // Taller cards for images
              ),
              itemCount: ArabicConstants.gojolList.length,
              itemBuilder: (context, index) {
                final gojol = ArabicConstants.gojolList[index];
                return GojolCard(
                  onTap: () {
                    context.push(
                      Routes.surahDetails,
                      extra: gojol,
                    );
                  },
                  item: gojol,
                  index: index,
                  textStyle: BanglaTypo.headline2,
                  subtitleStyle: BanglaTypo.bodyLarge,
                  titleFontSize: 28.sp,
                  subtitleFontSize: 20.sp,
                  colorPalette: CardColorPalettes.fruits,
                  errorIcon: Icons.music_note,
                  audioPlayerService: _audioPlayerService,
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
