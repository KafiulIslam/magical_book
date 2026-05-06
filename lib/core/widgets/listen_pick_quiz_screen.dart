import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/audio_path.dart';
import '../services/audio_player_service.dart';
import '../services/tts_service.dart';

class ListenPickQuizItem {
  final String id;
  final String label;
  final String? audioPath;
  final String? speakText;

  const ListenPickQuizItem({
    required this.id,
    required this.label,
    this.audioPath,
    this.speakText,
  });
}

class ListenPickQuizScreen extends StatefulWidget {
  final String title;
  final List<ListenPickQuizItem> items;
  final List<List<Color>> colorPalette;
  final bool useRtlLayout;

  const ListenPickQuizScreen({
    super.key,
    required this.title,
    required this.items,
    required this.colorPalette,
    this.useRtlLayout = false,
  });

  @override
  State<ListenPickQuizScreen> createState() => _ListenPickQuizScreenState();
}

class _ListenPickQuizScreenState extends State<ListenPickQuizScreen> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  final TtsService _ttsService = TtsService();
  final Random _random = Random();

  static const int _totalQuestions = 10;
  static const int _secondsPerQuestion = 180;

  late final List<ListenPickQuizItem> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int _secondsLeft = _secondsPerQuestion;
  String? _selectedId;
  bool _isAnswered = false;
  bool _isCorrect = false;
  Timer? _timer;

  ListenPickQuizItem get _currentQuestion => _questions[_currentIndex];

  @override
  void initState() {
    super.initState();
    _ttsService.initialize();
    _questions = _buildQuestionSet(widget.items);
    _startQuestion();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayerService.stop();
    _ttsService.stop();
    super.dispose();
  }

  List<ListenPickQuizItem> _buildQuestionSet(List<ListenPickQuizItem> items) {
    final pool = [...items]..shuffle();
    if (pool.length >= _totalQuestions) {
      return pool.take(_totalQuestions).toList();
    }
    final result = <ListenPickQuizItem>[...pool];
    while (result.length < _totalQuestions) {
      result.add(items[_random.nextInt(items.length)]);
    }
    result.shuffle();
    return result;
  }

  Future<void> _playPrompt() async {
    await _audioPlayerService.stop();
    await _ttsService.stop();

    if (_currentQuestion.audioPath != null && _currentQuestion.audioPath!.isNotEmpty) {
      await _audioPlayerService.play(
        _currentQuestion.audioPath!,
        itemId: 'quiz_${_currentQuestion.id}_$_currentIndex',
      );
    } else {
      await _ttsService.speak(_currentQuestion.speakText ?? _currentQuestion.label);
    }
  }

  Future<void> _playFeedbackSound(bool isCorrect) async {
    await _audioPlayerService.stop();
    await _audioPlayerService.play(
      isCorrect ? AudioPath.correctAnswer : AudioPath.wrongAnswer,
      itemId: isCorrect ? 'quiz_correct' : 'quiz_wrong',
    );
  }

  void _startQuestion() {
    _timer?.cancel();
    _secondsLeft = _secondsPerQuestion;
    _selectedId = null;
    _isAnswered = false;
    _isCorrect = false;
    _playPrompt();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsLeft <= 1) {
        _onTimeout();
      } else {
        setState(() => _secondsLeft--);
      }
    });
    setState(() {});
  }

  Future<void> _onTimeout() async {
    _timer?.cancel();
    setState(() {
      _isAnswered = true;
      _isCorrect = false;
      _selectedId = null;
    });
    await _playFeedbackSound(false);
    await Future.delayed(const Duration(milliseconds: 900));
    _goNext();
  }

  Future<void> _onSelect(ListenPickQuizItem item) async {
    if (_isAnswered) return;
    _timer?.cancel();

    final correct = item.id == _currentQuestion.id;
    setState(() {
      _selectedId = item.id;
      _isAnswered = true;
      _isCorrect = correct;
      if (correct) _score++;
    });

    await _playFeedbackSound(correct);
    await Future.delayed(const Duration(milliseconds: 900));
    _goNext();
  }

  void _goNext() {
    if (_currentIndex >= _totalQuestions - 1) {
      _showResultSheet();
      return;
    }
    _currentIndex++;
    _startQuestion();
  }

  void _showResultSheet() {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        final percent = ((_score / _totalQuestions) * 100).round();
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Quiz Complete',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'Score: $_score/$_totalQuestions ($percent%)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _score = 0;
                            _currentIndex = 0;
                          });
                          _startQuestion();
                        },
                        child: const Text('Try Again'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(this.context).pop();
                        },
                        child: const Text('Back'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _borderColorFor(ListenPickQuizItem item) {
    if (!_isAnswered) return Colors.white.withOpacity(0.3);
    if (item.id == _currentQuestion.id) return Colors.greenAccent;
    if (item.id == _selectedId && !_isCorrect) return Colors.redAccent;
    return Colors.white.withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentIndex + 1}/$_totalQuestions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: _secondsLeft / _secondsPerQuestion,
              minHeight: 8,
              borderRadius: BorderRadius.circular(999),
            ),
            const SizedBox(height: 6),
            Text('Time left: ${_secondsLeft}s'),
            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Listen and tap the correct card',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: _playPrompt,
                  icon: const Icon(Icons.replay_circle_filled_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Directionality(
                textDirection:
                    widget.useRtlLayout ? TextDirection.rtl : TextDirection.ltr,
                child: GridView.builder(
                  itemCount: widget.items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    final colors =
                        widget.colorPalette[index % widget.colorPalette.length];
                    return InkWell(
                      onTap: () => _onSelect(item),
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(colors: colors),
                          border: Border.all(
                            color: _borderColorFor(item),
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            item.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
