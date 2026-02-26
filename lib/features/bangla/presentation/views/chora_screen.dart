import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/common_rhyme_card.dart';
import '../../../../core/widgets/card_color_palettes.dart';

class ChoraScreen extends StatefulWidget {
  const ChoraScreen({super.key});

  @override
  State<ChoraScreen> createState() => _ChoraScreenState();
}

class _ChoraScreenState extends State<ChoraScreen> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  @override
  void dispose() {
    _audioPlayerService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          _audioPlayerService.stop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'বাংলা ছড়া',
            style: BanglaTypo.headline1.copyWith(fontSize: 24.sp),
          ),
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: BanglaConstants.banglaChora.length,
            separatorBuilder: (_, index) => const Gap(16),
            itemBuilder: (context, index) {
              final chora = BanglaConstants.banglaChora[index];
              return CommonRhymeCard(
                title: chora.title,
                image: chora.image,
                index: index,
                textStyle: BanglaTypo.headline3,
                colorPalette: CardColorPalettes.days,
                imageWidth: 120,
                imageHeight: 125,
                audioPlayerService: _audioPlayerService,
                audioPath: chora.audio,
                itemId: chora.id.toString(),
              );
            },
          ),
        ),
      ),
    );
  }
}
