import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/audio_feature_keys.dart';
import '../../../../core/constants/math_constant.dart';
import '../../../../core/services/audio_toggle_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/widgets/listen_pick_quiz_screen.dart';
import '../widgets/math_number_card.dart';

class EnglishNumbersScreen extends StatefulWidget {
  const EnglishNumbersScreen({super.key});

  @override
  State<EnglishNumbersScreen> createState() => _EnglishNumbersScreenState();
}

class _EnglishNumbersScreenState extends State<EnglishNumbersScreen> {
  late final TtsService _ttsService;
  final AudioToggleService _audioToggleService = AudioToggleService();

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _ttsService = TtsService();
    _ttsService.initialize();
    _audioToggleService.initialize();
    _audioToggleService.addStateChangeHandler(_onStateChanged);
  }

  @override
  void dispose() {
    _audioToggleService.removeStateChangeHandler(_onStateChanged);
    super.dispose();
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
    final isGlobalEnabled =
        _audioToggleService.isFeatureEnabled(AudioFeatureKeys.englishNumbers);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'English Numbers',
          style: EnglishTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        actions: [
          IconButton(
            onPressed: _openQuiz,
            icon: const Icon(Icons.quiz_outlined, color: AppColors.primary),
          ),
          IconButton(
            onPressed: () => _audioToggleService.toggleFeature(
              AudioFeatureKeys.englishNumbers,
            ),
            icon: Icon(
              isGlobalEnabled ? Icons.volume_up : Icons.volume_off,
              color: AppColors.primary,
            ),
          ),
        ],
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

  String _numberToWord(String number) {
    const numberWords = {
      '0': 'zero',
      '1': 'one',
      '2': 'two',
      '3': 'three',
      '4': 'four',
      '5': 'five',
      '6': 'six',
      '7': 'seven',
      '8': 'eight',
      '9': 'nine',
      '10': 'ten',
    };
    return numberWords[number] ?? number;
  }

  void _openQuiz() {
    final items = MathConstants.englishNumbers
        .map(
          (number) => ListenPickQuizItem(
            id: 'en_num_$number',
            label: number,
            speakText: _numberToWord(number),
          ),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ListenPickQuizScreen(
          title: 'English Number Quiz',
          items: items,
          colorPalette: CardColorPalettes.alphabet,
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
          colors: [AppColors.action, AppColors.reward],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.action.withOpacity(0.3),
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
            'English Numbers',
            style: EnglishTypo.headline2.copyWith(
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
            'Learn English Numerals (0-10)',
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
      itemCount: MathConstants.englishNumbers.length,
      itemBuilder: (context, index) {
        final number = MathConstants.englishNumbers[index];
        return MathNumberCard(
          letter: number,
          colorPalette: CardColorPalettes.alphabet,
          ttsService: _ttsService,
          featureKey: AudioFeatureKeys.englishNumbers,
          cardId: number,
        );
      },
    );
  }
}
