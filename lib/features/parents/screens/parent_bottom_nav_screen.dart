import 'package:flutter/material.dart';
import 'package:level_up_heroes/features/parents/screens/reports_screen.dart';
import 'package:level_up_heroes/features/parents/screens/rewards_screen.dart';
import 'package:level_up_heroes/features/parents/screens/tasks-screen.dart';

import '../../../core/constants/app_colors.dart';
import 'parent_home_screen.dart';


class ParentBottomNavScreen extends StatefulWidget {
  const ParentBottomNavScreen({super.key});

  @override
  State<ParentBottomNavScreen> createState() => _ParentBottomNavScreenState();
}

class _ParentBottomNavScreenState extends State<ParentBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const ParentHomeScreen(),
    const TasksScreen(),
    const RewardsScreen(),
    const ReportsScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(2),
            topLeft: Radius.circular(2),
          ),
          child: BottomNavigationBar(
            elevation: 5,
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            iconSize: 30,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
              BottomNavigationBarItem(icon: Icon(Icons.task), label: 'المهام'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'المكافآت'),
              BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'الطلبات'),
            ],
          ),
        ),
      ),
    );
  }
}
