import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/arabic_constant.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../widgets/arabic_month_name_card.dart';

/// Lists the twelve Hijri (Islamic) calendar months in Arabic with transliteration and Bangla.
class ArabicMonthsNameScreen extends StatefulWidget {
  const ArabicMonthsNameScreen({super.key});

  @override
  State<ArabicMonthsNameScreen> createState() => _ArabicMonthsNameScreenState();
}

class _ArabicMonthsNameScreenState extends State<ArabicMonthsNameScreen> {
  late final TtsService _ttsService;

  void _onTtsChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _ttsService = TtsService();
    _ttsService.initialize();
    _ttsService.addStateChangeHandler(_onTtsChanged);
  }

  @override
  void dispose() {
    _ttsService.removeStateChangeHandler(_onTtsChanged);
    super.dispose();
  }

  int _crossAxisCount(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 900) return 4;
    if (w > 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final months = ArabicConstants.arabicMonthsNames;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'আরবি মাস',
          style: BanglaTypo.headline1.copyWith(fontSize: 22.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    AppColors.info.withOpacity(0.85),
                    AppColors.primary.withOpacity(0.75),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'হিজরি বর্ষের ১২ মাস',
                    style: BanglaTypo.headline2.copyWith(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Gap(6.h),
                  Text(
                    'Twelve months of the Islamic (Hijri) calendar',
                    style: EnglishTypo.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ],
              ),
            ),
            Gap(16.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount(context),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.95,
              ),
              itemCount: months.length,
              itemBuilder: (context, index) {
                return ArabicMonthNameCard(
                  month: months[index],
                  index: index,
                  colorPalette: CardColorPalettes.months,
                  ttsService: _ttsService,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
