import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String avatarUrl;
  int streak;
  int hearts;
  int gems;
  int totalXp;

  UserProfile({
    required this.name,
    required this.avatarUrl,
    this.streak = 0,
    this.hearts = 5,
    this.gems = 0,
    this.totalXp = 0,
  });
}

class Topic {
  final String id;
  final String title;
  final String description;
  final List<Lesson> lessons;

  Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
  });
}

class Lesson {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final bool isLocked;
  final List<Question> questions;

  Lesson({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    this.isCompleted = false,
    this.isLocked = true,
    required this.questions,
  });
}

enum QuestionType { multipleChoice, trueFalse }

class Question {
  final String id;
  final String prompt;
  final QuestionType type;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  Question({
    required this.id,
    required this.prompt,
    required this.type,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });
}
