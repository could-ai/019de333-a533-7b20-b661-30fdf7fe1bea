import 'package:flutter/material.dart';
import '../models/models.dart';
import '../core/theme.dart';

final UserProfile mockUser = UserProfile(
  name: 'Alex Investor',
  avatarUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=Alex',
  streak: 5,
  hearts: 4,
  gems: 120,
  totalXp: 450,
);

final List<Topic> mockTopics = [
  Topic(
    id: 't1',
    title: 'Personal Finance Basics',
    description: 'Master the fundamentals of budgeting and saving.',
    lessons: [
      Lesson(
        id: 'l1',
        title: 'What is Money?',
        icon: Icons.payments_rounded,
        color: AppColors.primary,
        isCompleted: true,
        isLocked: false,
        questions: [
          Question(
            id: 'q1',
            prompt: 'Which of the following is a primary function of money?',
            type: QuestionType.multipleChoice,
            options: ['Medium of exchange', 'Something to eat', 'Building material', 'Entertainment'],
            correctOptionIndex: 0,
            explanation: 'Money acts as a medium of exchange, making it easier to trade goods and services compared to bartering.',
          ),
          Question(
            id: 'q2',
            prompt: 'Fiat money has intrinsic value (e.g., gold coins).',
            type: QuestionType.trueFalse,
            options: ['True', 'False'],
            correctOptionIndex: 1,
            explanation: 'Fiat money has no intrinsic value; its value comes from government decree and trust.',
          ),
        ],
      ),
      Lesson(
        id: 'l2',
        title: 'Budgeting 101',
        icon: Icons.account_balance_wallet_rounded,
        color: AppColors.secondary,
        isCompleted: false,
        isLocked: false,
        questions: [
          Question(
            id: 'q3',
            prompt: 'What does the 50/30/20 rule recommend?',
            type: QuestionType.multipleChoice,
            options: [
              '50% savings, 30% needs, 20% wants',
              '50% needs, 30% wants, 20% savings',
              '50% wants, 30% savings, 20% needs',
              'None of the above'
            ],
            correctOptionIndex: 1,
            explanation: 'The 50/30/20 rule suggests allocating 50% of your income to needs, 30% to wants, and 20% to savings and debt repayment.',
          ),
        ],
      ),
      Lesson(
        id: 'l3',
        title: 'Emergency Funds',
        icon: Icons.health_and_safety_rounded,
        color: AppColors.warning,
        isCompleted: false,
        isLocked: true,
        questions: [],
      ),
    ],
  ),
  Topic(
    id: 't2',
    title: 'Intro to Economics',
    description: 'Understand how markets and economies work.',
    lessons: [
      Lesson(
        id: 'l4',
        title: 'Supply & Demand',
        icon: Icons.trending_up_rounded,
        color: Colors.purple,
        isCompleted: false,
        isLocked: true,
        questions: [
          Question(
            id: 'q4',
            prompt: 'If the price of a good increases, what typically happens to demand?',
            type: QuestionType.multipleChoice,
            options: ['It increases', 'It decreases', 'It stays the same', 'It doubles'],
            correctOptionIndex: 1,
            explanation: 'The law of demand states that as prices rise, consumer demand usually falls.',
          ),
        ],
      ),
      Lesson(
        id: 'l5',
        title: 'Inflation',
        icon: Icons.price_change_rounded,
        color: Colors.orange,
        isCompleted: false,
        isLocked: true,
        questions: [],
      ),
    ],
  ),
];
