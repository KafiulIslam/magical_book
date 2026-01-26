import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magical_book/features/bangla/presentation/widgets/bangla_fruit_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/english_constant.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/common_image_text_card.dart';
import '../../../../core/widgets/card_color_palettes.dart';

class EnglishFruitScreen extends StatefulWidget {
  const EnglishFruitScreen({super.key});

  @override
  State<EnglishFruitScreen> createState() => _EnglishFruitScreenState();
}

class _EnglishFruitScreenState extends State<EnglishFruitScreen> {

  late final TtsService _ttsService;

  void _onTtsStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _ttsService = TtsService();
    _ttsService.initialize();
    _ttsService.addStateChangeHandler(_onTtsStateChanged);
  }

  @override
  void dispose() {
    _ttsService.removeStateChangeHandler(_onTtsStateChanged);
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
          'Fruits',
          style: EnglishTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.72, // Slightly taller cards to accommodate longer text
          ),
          itemCount: EnglishConstants.fruitsName.length,
          itemBuilder: (context, index) {
            final fruit = EnglishConstants.fruitsName[index];
            return BanglaFruitCard(
              item: fruit,
              index: index,
              textStyle: BanglaTypo.headline2,
              fontSize: 20.sp,
              colorPalette: CardColorPalettes.fruits,
              errorIcon: Icons.apple,
              imageFit: BoxFit.contain,
              useFlexibleForText: true,
              ttsService: _ttsService,
            );
          },
        ),
      ),
    );
  }
}

