import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/english_constant.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../../../../core/services/audio_player_service.dart';
import '../widgets/english_rhyme_card.dart';

class EnglishRhymesScreen extends StatefulWidget {
  const EnglishRhymesScreen({super.key});

  @override
  State<EnglishRhymesScreen> createState() => _EnglishRhymesScreenState();
}

class _EnglishRhymesScreenState extends State<EnglishRhymesScreen> {
  late final AudioPlayerService _audioPlayerService;

  void _onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onCompleted() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _audioPlayerService = AudioPlayerService();
    _audioPlayerService.addStateChangeHandler(_onStateChanged);
    _audioPlayerService.addCompletionHandler(_onCompleted);
  }

  @override
  void dispose() {
    _audioPlayerService.removeStateChangeHandler(_onStateChanged);
    _audioPlayerService.removeCompletionHandler(_onCompleted);
    // Stop audio when navigating away
    _audioPlayerService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'English Rhymes',
          style: EnglishTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: EnglishConstants.englishRhymes.length,
          separatorBuilder: (_, index) => const Gap(16),
          itemBuilder: (context, index) {
            final rhyme = EnglishConstants.englishRhymes[index];
            return EnglishRhymeCard(
              rhyme: rhyme,
              index: index,
              textStyle: EnglishTypo.headline3,
              colorPalette: CardColorPalettes.days,
              imageWidth: 130,
              imageHeight: 140,
              audioPlayerService: _audioPlayerService,
            );
          },
        ),
      ),
    );
  }
}
