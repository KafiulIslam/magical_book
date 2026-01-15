import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../math/model/multiplication_model.dart';

class SurahDetailsScreen extends StatefulWidget {
  final MultiplicationModel surah;

  const SurahDetailsScreen({
    super.key,
    required this.surah,
  });

  @override
  State<SurahDetailsScreen> createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();

  String get _itemId => 'surah_${widget.surah.id}';

  void _onAudioStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _audioPlayerService.addStateChangeHandler(_onAudioStateChanged);
  }

  @override
  void dispose() {
    _audioPlayerService.removeStateChangeHandler(_onAudioStateChanged);
    super.dispose();
  }

  Future<void> _togglePlayStop() async {
    if (_audioPlayerService.isPlayingItem(_itemId)) {
      await _audioPlayerService.stop();
    } else {
      await _audioPlayerService.play(widget.surah.audio, itemId: _itemId);
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = _audioPlayerService.isPlayingItem(_itemId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.surah.subTitle,
          style: BanglaTypo.headline1.copyWith(fontSize: 20.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
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
          const Gap(8),
        ],
      ),
      body: PhotoView(
        imageProvider: AssetImage(widget.surah.image),
        minScale: PhotoViewComputedScale.contained * 0.5,
        maxScale: PhotoViewComputedScale.covered * 4.0,
        initialScale: PhotoViewComputedScale.contained,
        backgroundDecoration: const BoxDecoration(
          color: AppColors.background,
        ),
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.menu_book,
                  size: 80,
                  color: AppColors.textSecondary,
                ),
                const Gap(16),
                Text(
                  'Image not found',
                  style: EnglishTypo.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
