import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/audio_feature_keys.dart';
import '../../../../core/constants/audio_path.dart';
import '../../../../core/constants/math_constant.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/services/audio_toggle_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/widgets/listen_pick_quiz_screen.dart';
import '../widgets/math_number_card.dart';

class BanglaNumbersScreen extends StatefulWidget {
  const BanglaNumbersScreen({super.key});

  @override
  State<BanglaNumbersScreen> createState() => _BanglaNumbersScreenState();
}

class _BanglaNumbersScreenState extends State<BanglaNumbersScreen> {
  static const String _fullAudioItemId = 'bangla_numbers_full';

  late final TtsService _ttsService;
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  final AudioToggleService _audioToggleService = AudioToggleService();

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _ttsService = TtsService();
    _ttsService.initialize();
    _audioPlayerService.addStateChangeHandler(_onStateChanged);
    _audioPlayerService.addCompletionHandler(_onStateChanged);
    _audioToggleService.initialize();
    _audioToggleService.addStateChangeHandler(_onStateChanged);
  }

  @override
  void dispose() {
    _audioPlayerService.removeStateChangeHandler(_onStateChanged);
    _audioPlayerService.removeCompletionHandler(_onStateChanged);
    _audioToggleService.removeStateChangeHandler(_onStateChanged);
    _audioPlayerService.stop();
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    if (!_audioToggleService.isFeatureEnabled(AudioFeatureKeys.banglaNumbers)) {
      return;
    }

    if (_audioPlayerService.isPlayingItem(_fullAudioItemId)) {
      await _audioPlayerService.stop();
    } else {
      await _audioPlayerService.play(
        AudioPath.banglaSongkha,
        itemId: _fullAudioItemId,
      );
    }

    if (mounted) setState(() {});
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
        _audioToggleService.isFeatureEnabled(AudioFeatureKeys.banglaNumbers);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _audioPlayerService.stop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'বাংলা সংখ্যা',
            style: BanglaTypo.headline1.copyWith(fontSize: 24.sp),
          ),
          actions: [
            IconButton(
              onPressed: _openQuiz,
              icon: const Icon(Icons.quiz_outlined, color: AppColors.primary),
            ),
            IconButton(
              onPressed: () async {
                final enabled = await _audioToggleService.toggleFeature(
                  AudioFeatureKeys.banglaNumbers,
                );
                if (!enabled) {
                  await _audioPlayerService.stop();
                }
              },
              icon: Icon(
                isGlobalEnabled ? Icons.volume_up : Icons.volume_off,
                color: AppColors.primary,
              ),
            ),
            const Gap(8),
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
      ),
    );
  }

  void _openQuiz() {
    final items = MathConstants.banglaNumbers
        .map(
          (number) => ListenPickQuizItem(
            id: 'bn_num_${number.id}',
            label: number.number,
            audioPath: number.audio.isNotEmpty ? number.audio : null,
            speakText: number.audio.isEmpty ? number.number : null,
          ),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ListenPickQuizScreen(
          title: 'বাংলা সংখ্যা কুইজ',
          items: items,
          colorPalette: CardColorPalettes.alphabet,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isGlobalEnabled =
        _audioToggleService.isFeatureEnabled(AudioFeatureKeys.banglaNumbers);
    final isPlaying = _audioPlayerService.isPlayingItem(_fullAudioItemId);
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text(
                  'Bangla Numbers - Learn Bengali Numerals',
                  textAlign: TextAlign.start,
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
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: !isGlobalEnabled ? null : _togglePlayStop,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.3),
                ),
                child: Icon(
                  isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
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
          letter: number.number,
          fontFamily: 'Kalpurush',
          colorPalette: CardColorPalettes.alphabet,
          ttsService: _ttsService,
          featureKey: AudioFeatureKeys.banglaNumbers,
          cardId: 'bn_num_${number.id}',
          audioPath: number.audio.isNotEmpty ? number.audio : null,
        );
      },
    );
  }
}
