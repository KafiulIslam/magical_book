import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/math_constant.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../../../../core/services/tts_service.dart';
import '../widgets/math_number_card.dart';

class BanglaNumbersScreen extends StatefulWidget {
  const BanglaNumbersScreen({super.key});

  @override
  State<BanglaNumbersScreen> createState() => _BanglaNumbersScreenState();
}

class _BanglaNumbersScreenState extends State<BanglaNumbersScreen> {
  late final TtsService _ttsService;

  @override
  void initState() {
    super.initState();
    _ttsService = TtsService();
    _ttsService.initialize();
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) {
      return 5; // Large tablets/desktop
    } else if (width > 600) {
      return 4; // Tablets
    } else {
      return 3; // Mobile phones
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'বাংলা সংখ্যা',
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
            _buildHeader(),
            const Gap(24),
            // Numbers Grid
            _buildNumbersGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.info],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
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
            'বাংলা সংখ্যা',
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
            'Bangla Numbers - Learn Bengali Numerals',
            textAlign: TextAlign.center,
            style: EnglishTypo.bodyLarge.copyWith(
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

  Widget _buildNumbersGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: MathConstants.banglaNumbers.length,
      itemBuilder: (context, index) {
        final number = MathConstants.banglaNumbers[index];
        return MathNumberCard(
          letter: number,
          fontFamily: 'Kalpurush',
          colorPalette: CardColorPalettes.alphabet,
          ttsService: _ttsService,
        );
      },
    );
  }
}
