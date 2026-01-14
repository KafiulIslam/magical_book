import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:magical_book/features/arabic/model/arabic_alphabet_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/arabic_constant.dart';
import '../../../../core/constants/audio_path.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/common_alphabet_card.dart';
import '../../../../core/widgets/card_color_palettes.dart';

class ArabicAlphabetScreen extends StatefulWidget {
  const ArabicAlphabetScreen({super.key});

  @override
  State<ArabicAlphabetScreen> createState() => _ArabicAlphabetScreenState();
}

class _ArabicAlphabetScreenState extends State<ArabicAlphabetScreen> {
  static const String _alphabetItemId = 'arabic_alphabet_full';
  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  @override
  void initState() {
    super.initState();
    // Update UI when playback completes
    _audioPlayerService.setCompletionHandler(() {
      if (mounted) setState(() {});
    });
    // Update UI when play/stop state changes
    _audioPlayerService.addStateChangeHandler(() {
      if (mounted) setState(() {});
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
      return 5; // Large tablets/desktop - fewer columns for larger cards
    } else if (width > 600) {
      return 4; // Tablets - fewer columns for larger cards
    } else {
      return 3; // Mobile phones - fewer columns for larger cards
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying =
        _audioPlayerService.isPlayingItem(_alphabetItemId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'আরবি বর্নমালা',
          style: BanglaTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        actions: [
          IconButton(
            onPressed: _togglePlayStop,
            icon: Icon(
              isPlaying ? Icons.stop_circle : Icons.play_circle_fill,
              color: AppColors.primary,
              size: 34.sp,
            ),
            tooltip: isPlaying ? 'Stop' : 'Play',
          ),
          const Gap(8)
        ],
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Gap(16),
            _buildLetterGrid(
              context,
              ArabicConstants.arabicAlphabet,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _togglePlayStop() async {

    final isPlaying = _audioPlayerService.isPlayingItem(_alphabetItemId);
    if (isPlaying) {
      await _audioPlayerService.stop();
    } else {
      await _audioPlayerService.play(
        AudioPath.allArabicAlphabet,
        itemId: _alphabetItemId,
      );
    }
    if (mounted) setState(() {});
  }

  Widget _buildLetterGrid(BuildContext context, List<ArabicAlphabetModel> letters) {
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
        return CommonAlphabetCard(
          letter: letter.letter,
          fontFamily: 'NotoSansArabic',
          colorPalette: CardColorPalettes.alphabet,
        );
      },
    );
  }

}
