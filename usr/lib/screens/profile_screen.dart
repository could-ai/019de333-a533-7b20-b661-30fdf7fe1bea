import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/mock_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 32),
          const Divider(color: AppColors.border, thickness: 2),
          const SizedBox(height: 32),
          Text('Statistics', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildStatsGrid(),
          const SizedBox(height: 32),
          Text('Achievements', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildAchievementsList(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.surface,
          backgroundImage: NetworkImage(mockUser.avatarUrl),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mockUser.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Joined May 2026',
                style: TextStyle(color: AppColors.textMuted, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _buildStatCard(Icons.local_fire_department_rounded, AppColors.warning, mockUser.streak.toString(), 'Day Streak'),
        _buildStatCard(Icons.bolt_rounded, AppColors.secondary, mockUser.totalXp.toString(), 'Total XP'),
        _buildStatCard(Icons.emoji_events_rounded, Colors.amber, 'Bronze', 'Current League'),
        _buildStatCard(Icons.verified_rounded, AppColors.primary, '1', 'Top 3 Finishes'),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, Color color, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsList() {
    return Column(
      children: [
        _buildAchievementTile(
          icon: Icons.savings_rounded,
          color: AppColors.primary,
          title: 'Penny Pincher',
          description: 'Complete the Personal Finance Basics module.',
          progress: 1.0,
        ),
        const SizedBox(height: 16),
        _buildAchievementTile(
          icon: Icons.trending_up_rounded,
          color: Colors.purple,
          title: 'Market Maker',
          description: 'Complete the Intro to Economics module.',
          progress: 0.2,
        ),
      ],
    );
  }

  Widget _buildAchievementTile({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
    required double progress,
  }) {
    final isCompleted = progress >= 1.0;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCompleted ? color.withOpacity(0.1) : AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isCompleted ? color : AppColors.textMuted,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(isCompleted ? AppColors.warning : color),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
