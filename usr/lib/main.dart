import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'data/mock_data.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/leaderboard_screen.dart';

void main() {
  runApp(const FinLearnApp());
}

class FinLearnApp extends StatelessWidget {
  const FinLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinLearn',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const LeaderboardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTopBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 2)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.secondary,
          unselectedItemColor: AppColors.textMuted,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, size: 32),
              activeIcon: Icon(Icons.home_rounded, size: 36),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_rounded, size: 32),
              activeIcon: Icon(Icons.leaderboard_rounded, size: 36),
              label: 'Leaderboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded, size: 32),
              activeIcon: Icon(Icons.person_rounded, size: 36),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildTopBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatIndicator(Icons.local_fire_department_rounded, AppColors.warning, mockUser.streak.toString()),
          _buildStatIndicator(Icons.diamond_rounded, AppColors.secondary, mockUser.gems.toString()),
          _buildStatIndicator(Icons.favorite_rounded, AppColors.danger, mockUser.hearts.toString()),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(
          color: AppColors.border,
          height: 2.0,
        ),
      ),
    );
  }

  Widget _buildStatIndicator(IconData icon, Color color, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
