import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:magical_book/features/bangla/models/common_content_model.dart';
import 'package:magical_book/features/bangla/presentation/widgets/borno_mala_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/constants/audio_path.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../../../../core/services/audio_player_service.dart';

class BornoMalaScreen extends StatefulWidget {
  const BornoMalaScreen({super.key});

  @override
  State<BornoMalaScreen> createState() => _BornoMalaScreenState();
}

class _BornoMalaScreenState extends State<BornoMalaScreen> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  void _onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _audioPlayerService.addStateChangeHandler(_onStateChanged);
  }

  @override
  void dispose() {
    _audioPlayerService.removeStateChangeHandler(_onStateChanged);
    super.dispose();
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) {
      return 5; // Large tablets/desktop - fewer columns for larger cards
    } else if (width > 600) {
      return 4; // Tablets - fewer columns for larger cards
    } else {
      return 3; // Mobile phones - fewer columns for larger cards
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'বর্ণমালা',
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
            // Shoroborno Section
            _buildHeader(
              title: 'বাংলা স্বরবর্ণ',
              subtitle: 'Shoroborno - Learn Bangla Vowels',
              gradientColors: [AppColors.primary, AppColors.info],
              emoji: '✨',
              audioPath: AudioPath.shoroBorno,
            ),
            const Gap(16),
            _buildLetterGrid(
              context,
              BanglaConstants.banglaShorobornos,
            ),
            const Gap(32),
            // Byanjonborno Section
            _buildHeader(
              title: 'বাংলা ব্যঞ্জনবর্ণ',
              subtitle: 'Byanjonborno - Learn Bangla Consonants',
              gradientColors: [AppColors.action, AppColors.reward],
              emoji: '🎯',
              audioPath: AudioPath.banjonBorno, // Add audio path when available
            ),
            const Gap(16),
            _buildLetterGrid(
              context,
              BanglaConstants.banglaByanjonbornos,
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
    required String audioPath,
  }) {
    final bool isPlaying = _audioPlayerService.isPlayingAudio(audioPath);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: BanglaTypo.headline2.copyWith(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                Text(subtitle,
                    textAlign: TextAlign.center,
                    style: EnglishTypo.bodyLarge.copyWith(
                      color: Colors.white,
                      shadows: [
                        const Shadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          if (audioPath.isNotEmpty)
            InkWell(
              onTap: () async {
                if (isPlaying) {
                  await _audioPlayerService.stop();
                } else {
                  await _audioPlayerService.play(audioPath);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.3)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildLetterGrid(
      BuildContext context, List<CommonContentModel> letters) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9, // Slightly wider for better visibility
      ),
      itemCount: letters.length,
      itemBuilder: (context, index) {
        final letter = letters[index];
        return BornoMalaCard(
          letter: letter.title,
          fontFamily: 'Kalpurush',
          colorPalette: CardColorPalettes.alphabet,
          audioPath: letter.audio,
        );
      },
    );
  }
}
