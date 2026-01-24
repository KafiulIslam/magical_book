import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bangla_constants.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../../../../core/services/tts_service.dart';
import '../widgets/bangla_fruit_card.dart';

class BanglaFruitScreen extends StatefulWidget {
  const BanglaFruitScreen({super.key});

  @override
  State<BanglaFruitScreen> createState() => _BanglaFruitScreenState();
}

class _BanglaFruitScreenState extends State<BanglaFruitScreen> {
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
          'ফলের নাম',
          style: BanglaTypo.headline1.copyWith(fontSize: 24.sp),
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
            childAspectRatio: 0.75, // Taller cards for images
          ),
          itemCount: BanglaConstants.banglaFolerNam.length,
          itemBuilder: (context, index) {
            final fruit = BanglaConstants.banglaFolerNam[index];
            return BanglaFruitCard(
              item: fruit,
              index: index,
              textStyle: BanglaTypo.headline2,
              fontSize: 22.sp,
              colorPalette: CardColorPalettes.fruits,
              errorIcon: Icons.apple,
              imageFit: BoxFit.contain,
              useFlexibleForText: false,
              ttsService: _ttsService,
            );
          },
        ),
      ),
    );
  }
}
