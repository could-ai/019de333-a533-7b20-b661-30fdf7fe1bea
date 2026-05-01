import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/models.dart';
import '../widgets/bouncy_button.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _hasAnswered = false;
  bool _isCorrect = false;

  void _checkAnswer() {
    if (_selectedOptionIndex == null) return;
    
    final currentQuestion = widget.lesson.questions[_currentQuestionIndex];
    setState(() {
      _hasAnswered = true;
      _isCorrect = _selectedOptionIndex == currentQuestion.correctOptionIndex;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.lesson.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _hasAnswered = false;
        _isCorrect = false;
      });
    } else {
      // Lesson complete
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.stars_rounded, color: AppColors.warning, size: 80),
            const SizedBox(height: 16),
            const Text(
              'Lesson Complete!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.warning,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You earned +15 XP',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: BouncyButton(
                text: 'CONTINUE',
                color: AppColors.primary,
                shadowColor: AppColors.primaryShadow,
                onPressed: () {
                  Navigator.pop(context); // Close sheet
                  Navigator.pop(context); // Back to home
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lesson.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Coming Soon')),
        body: const Center(
          child: Text('This lesson is under construction!', style: TextStyle(fontSize: 18)),
        ),
      );
    }

    final question = widget.lesson.questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex) / widget.lesson.questions.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.surface,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_rounded, color: AppColors.danger),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose the correct answer',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      question.prompt,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ...question.options.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final text = entry.value;
                      final isSelected = _selectedOptionIndex == idx;
                      
                      Color cardColor = AppColors.background;
                      Color borderColor = AppColors.border;
                      Color textColor = AppColors.textMain;

                      if (_hasAnswered) {
                        if (idx == question.correctOptionIndex) {
                          cardColor = AppColors.primary.withOpacity(0.1);
                          borderColor = AppColors.primary;
                          textColor = AppColors.primaryShadow;
                        } else if (isSelected) {
                          cardColor = AppColors.danger.withOpacity(0.1);
                          borderColor = AppColors.danger;
                          textColor = AppColors.dangerShadow;
                        }
                      } else if (isSelected) {
                        cardColor = AppColors.secondary.withOpacity(0.1);
                        borderColor = AppColors.secondary;
                        textColor = AppColors.secondaryShadow;
                      }

                      return GestureDetector(
                        onTap: _hasAnswered
                            ? null
                            : () {
                                setState(() {
                                  _selectedOptionIndex = idx;
                                });
                              },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: borderColor, width: 2),
                          ),
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    if (!_hasAnswered) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: AppColors.border, width: 2)),
        ),
        child: BouncyButton(
          text: 'CHECK',
          color: _selectedOptionIndex == null ? AppColors.surface : AppColors.primary,
          shadowColor: _selectedOptionIndex == null ? AppColors.border : AppColors.primaryShadow,
          onPressed: _selectedOptionIndex == null ? () {} : _checkAnswer,
        ),
      );
    }

    final bgColor = _isCorrect ? AppColors.primary.withOpacity(0.1) : AppColors.danger.withOpacity(0.1);
    final fgColor = _isCorrect ? AppColors.primaryShadow : AppColors.dangerShadow;
    final icon = _isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded;
    final title = _isCorrect ? 'Nicely done!' : 'Incorrect';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: fgColor, size: 32),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: fgColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.lesson.questions[_currentQuestionIndex].explanation,
            style: TextStyle(
              color: fgColor.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          BouncyButton(
            text: 'CONTINUE',
            color: _isCorrect ? AppColors.primary : AppColors.danger,
            shadowColor: _isCorrect ? AppColors.primaryShadow : AppColors.dangerShadow,
            onPressed: _nextQuestion,
          ),
        ],
      ),
    );
  }
}
