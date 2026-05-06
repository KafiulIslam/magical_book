import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/audio_path.dart';
import '../../../../core/constants/audio_feature_keys.dart';
import '../../../../core/constants/english_constant.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/services/audio_toggle_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/common_alphabet_card.dart';
import '../../../../core/widgets/card_color_palettes.dart';
import '../../../../core/widgets/listen_pick_quiz_screen.dart';

class EnglishAlphabetScreen extends StatefulWidget {
  const EnglishAlphabetScreen({super.key});

  @override
  State<EnglishAlphabetScreen> createState() => _EnglishAlphabetScreenState();
}

class _EnglishAlphabetScreenState extends State<EnglishAlphabetScreen> {
  static const String _headerAudioItemId = 'english_alphabet_header';

  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  final AudioToggleService _audioToggleService = AudioToggleService();

  void _onAudioStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _audioPlayerService.addStateChangeHandler(_onAudioStateChanged);
    _audioPlayerService.addCompletionHandler(_onAudioStateChanged);
    _audioToggleService.initialize();
    _audioToggleService.addStateChangeHandler(_onAudioStateChanged);
  }

  @override
  void dispose() {
    _audioPlayerService.stop();
    _audioPlayerService.removeStateChangeHandler(_onAudioStateChanged);
    _audioPlayerService.removeCompletionHandler(_onAudioStateChanged);
    _audioToggleService.removeStateChangeHandler(_onAudioStateChanged);
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
    final isGlobalEnabled =
        _audioToggleService.isFeatureEnabled(AudioFeatureKeys.englishAlphabet);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alphabet',
          style: EnglishTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        actions: [
          IconButton(
            onPressed: _openQuiz,
            icon: const Icon(Icons.quiz_outlined, color: AppColors.primary),
          ),
          IconButton(
            onPressed: () async {
              final enabled = await _audioToggleService.toggleFeature(
                AudioFeatureKeys.englishAlphabet,
              );
              if (!enabled) {
                await _audioPlayerService.stop();
              }
            },
            icon: Icon(
              isGlobalEnabled ? Icons.volume_up : Icons.volume_off,
              color: AppColors.primary,
              size: 26.sp,
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
            // Alphabet Section
            _buildHeader(
              title: 'English Alphabet',
              subtitle: 'A to Z - Learn English Alphabet',
              gradientColors: [AppColors.primary, AppColors.info],
              emoji: '✨',
              audioPath: AudioPath.englishAllAlphabet,
            ),
            const Gap(16),
            _buildLetterGrid(context),
          ],
        ),
      ),
    );
  }

  void _openQuiz() {
    final items = EnglishConstants.englishAlphabet
        .map(
          (e) => ListenPickQuizItem(
            id: e.letter,
            label: e.letter,
            audioPath: e.audioPath,
          ),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ListenPickQuizScreen(
          title: 'Alphabet Quiz',
          items: items,
          colorPalette: CardColorPalettes.alphabet,
        ),
      ),
    );
  }

  Future<void> _toggleHeaderAudio(String audioPath) async {
    if (!_audioToggleService
        .isFeatureEnabled(AudioFeatureKeys.englishAlphabet)) {
      return;
    }
    final isPlaying = _audioPlayerService.isPlayingItem(_headerAudioItemId);
    if (isPlaying) {
      await _audioPlayerService.stop();
    } else {
      await _audioPlayerService.play(audioPath, itemId: _headerAudioItemId);
    }
    if (mounted) setState(() {});
  }

  Widget _buildHeader({
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required String emoji,
    required String audioPath,
  }) {
    final isGlobalEnabled =
        _audioToggleService.isFeatureEnabled(AudioFeatureKeys.englishAlphabet);
    final bool isPlaying = _audioPlayerService.isPlayingItem(_headerAudioItemId);

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
                    textAlign: TextAlign.start,
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
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: !isGlobalEnabled ? null : () => _toggleHeaderAudio(audioPath),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Icon(
                    isGlobalEnabled
                        ? (isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded)
                        : Icons.volume_off,
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

  Widget _buildLetterGrid(BuildContext context) {
    const letters = EnglishConstants.englishAlphabet;
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
        final item = letters[index];
        return CommonAlphabetCard(
          letter: item.letter,
          colorPalette: CardColorPalettes.alphabet,
          audioPath: item.audioPath,
          audioPlayerService: _audioPlayerService,
          featureKey: AudioFeatureKeys.englishAlphabet,
          cardId: item.letter,
        );
      },
    );
  }

}
