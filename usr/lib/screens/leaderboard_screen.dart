import 'package:flutter/material.dart';
import '../core/theme.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events_rounded, size: 80, color: AppColors.warning),
          SizedBox(height: 16),
          Text(
            'Leaderboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Compete with friends coming soon!',
            style: TextStyle(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
