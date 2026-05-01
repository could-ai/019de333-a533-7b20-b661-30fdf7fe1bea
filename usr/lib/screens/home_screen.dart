import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import 'lesson_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: mockTopics.length,
      itemBuilder: (context, index) {
        return _buildTopicSection(context, mockTopics[index], index);
      },
    );
  }

  Widget _buildTopicSection(BuildContext context, Topic topic, int topicIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: topicIndex % 2 == 0 ? AppColors.primary : AppColors.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section ${topicIndex + 1}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                topic.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                topic.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        ...topic.lessons.asMap().entries.map((entry) {
          final index = entry.key;
          final lesson = entry.value;
          return _buildLessonNode(context, lesson, index);
        }),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildLessonNode(BuildContext context, Lesson lesson, int index) {
    // Calculate a simple sine wave offset for the winding path look
    final offsets = [0.0, 40.0, 80.0, 40.0, 0.0, -40.0, -80.0, -40.0];
    final offset = offsets[index % offsets.length];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Transform.translate(
        offset: Offset(offset, 0),
        child: GestureDetector(
          onTap: lesson.isLocked
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LessonScreen(lesson: lesson),
                    ),
                  );
                },
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lesson.isLocked ? AppColors.surface : lesson.color,
                      border: Border.all(
                        color: lesson.isLocked ? AppColors.border : _getShadowColor(lesson.color),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: lesson.isLocked ? AppColors.border : _getShadowColor(lesson.color),
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      lesson.isLocked ? Icons.lock_rounded : lesson.icon,
                      color: lesson.isLocked ? AppColors.textMuted : Colors.white,
                      size: 40,
                    ),
                  ),
                  if (lesson.isCompleted)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.warning,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                lesson.title,
                style: TextStyle(
                  color: lesson.isLocked ? AppColors.textMuted : AppColors.textMain,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getShadowColor(Color baseColor) {
    if (baseColor == AppColors.primary) return AppColors.primaryShadow;
    if (baseColor == AppColors.secondary) return AppColors.secondaryShadow;
    if (baseColor == AppColors.warning) return AppColors.warningShadow;
    if (baseColor == Colors.purple) return Colors.purple[700]!;
    if (baseColor == Colors.orange) return Colors.orange[800]!;
    return Colors.black26;
  }
}
