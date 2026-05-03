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
  bool _isAnswerChecked = false;
  bool _isCorrect = false;

  void _checkAnswer() {
    if (_selectedOptionIndex == null) return;

    final question = widget.lesson.questions[_currentQuestionIndex];
    setState(() {
      _isAnswerChecked = true;
      _isCorrect = _selectedOptionIndex == question.correctOptionIndex;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.lesson.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _isAnswerChecked = false;
        _isCorrect = false;
      });
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.surface,
        title: Column(
          children: [
            Icon(Icons.emoji_events_rounded, color: AppColors.warning, size: 64),
            const SizedBox(height: 16),
            Text(
              'Lesson Complete!',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Text(
          'You have successfully completed ${widget.lesson.title}. Keep up the great work!',
          style: TextStyle(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          BouncyButton(
            onPressed: () {
              Navigator.of(context).pop(); // pop dialog
              Navigator.of(context).pop(); // pop screen
            },
            text: 'Continue',
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.lesson.questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + (_isAnswerChecked ? 1 : 0)) / widget.lesson.questions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: AppColors.textMuted),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 12,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.favorite_rounded, color: AppColors.danger, size: 24),
                const SizedBox(width: 4),
                Text(
                  '5',
                  style: TextStyle(
                    color: AppColors.danger,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1} of ${widget.lesson.questions.length}',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      question.prompt,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ...List.generate(question.options.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildOption(index, question.options[index], question.correctOptionIndex),
                      );
                    }),
                  ],
                ),
              ),
            ),
            _buildBottomBar(question),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index, String text, int correctIndex) {
    final isSelected = _selectedOptionIndex == index;
    
    Color borderColor = AppColors.border;
    Color bgColor = AppColors.surface;
    Color textColor = AppColors.textPrimary;

    if (_isAnswerChecked) {
      if (index == correctIndex) {
        borderColor = AppColors.success;
        bgColor = AppColors.success.withOpacity(0.1);
        textColor = AppColors.success;
      } else if (isSelected) {
        borderColor = AppColors.danger;
        bgColor = AppColors.danger.withOpacity(0.1);
        textColor = AppColors.danger;
      }
    } else if (isSelected) {
      borderColor = AppColors.primary;
      bgColor = AppColors.primary.withOpacity(0.1);
      textColor = AppColors.primary;
    }

    return GestureDetector(
      onTap: _isAnswerChecked
          ? null
          : () {
              setState(() {
                _selectedOptionIndex = index;
              });
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: isSelected || _isAnswerChecked ? 2 : 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 2),
                color: _isAnswerChecked && index == correctIndex
                    ? AppColors.success
                    : _isAnswerChecked && isSelected
                        ? AppColors.danger
                        : isSelected
                            ? AppColors.primary
                            : Colors.transparent,
              ),
              child: _isAnswerChecked && index == correctIndex
                  ? Icon(Icons.check, size: 16, color: Colors.white)
                  : _isAnswerChecked && isSelected
                      ? Icon(Icons.close, size: 16, color: Colors.white)
                      : isSelected
                          ? Center(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: isSelected || _isAnswerChecked ? FontWeight.bold : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(Question question) {
    if (!_isAnswerChecked) {
      return Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border, width: 2)),
        ),
        child: BouncyButton(
          onPressed: _selectedOptionIndex != null ? _checkAnswer : () {},
          text: 'Check Answer',
          color: _selectedOptionIndex != null ? AppColors.primary : AppColors.border,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: _isCorrect ? AppColors.success.withOpacity(0.1) : AppColors.danger.withOpacity(0.1),
        border: Border(
          top: BorderSide(
            color: _isCorrect ? AppColors.success : AppColors.danger,
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                _isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: _isCorrect ? AppColors.success : AppColors.danger,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _isCorrect ? 'Excellent!' : 'Not quite right',
                  style: TextStyle(
                    color: _isCorrect ? AppColors.success : AppColors.danger,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            question.explanation,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          BouncyButton(
            onPressed: _nextQuestion,
            text: _currentQuestionIndex < widget.lesson.questions.length - 1 ? 'Continue' : 'Finish Lesson',
            color: _isCorrect ? AppColors.success : AppColors.danger,
          ),
        ],
      ),
    );
  }
}
