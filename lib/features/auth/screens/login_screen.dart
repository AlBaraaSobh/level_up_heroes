import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';

import '../widget/animated_user_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(), //  يجعل الخلفية تمتد

        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  children: [
                    const Text(
                      '✨ بطل النقاط ✨',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'LevelUp Heroes',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'اختر نوع المستخدم للبدء',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),

                    // ✅ كرت ولي الأمر
                    AnimatedUserCard(
                      title: 'أنا ولي أمر',
                      subtitle: 'إدارة حسابات الأطفال و المتابعة',
                      buttonText: 'دخول كولي أمر',
                      color1: AppColors.primary,
                      color2: AppColors.accent,
                      icon: Icons.family_restroom,
                      onTap: () {
                        Navigator.pushNamed(context, '/parents_login_screen');
                      },
                      delay: 300,
                    ),
                    const SizedBox(height: 20),

                    // ✅ كرت الطفل
                    AnimatedUserCard(
                      title: 'أنا طفل',
                      subtitle: 'الدخول إلى حسابي',
                      buttonText: 'دخول كطفل',
                      color1: AppColors.accent,
                      color2: AppColors.primary, // سماوي مرح
                    //  color2: Color(0xFF4DD0E1), // سماوي مرح
                      icon: Icons.child_care,
                      onTap: () {
                        Navigator.pushNamed(context, '/kids_login_screen');
                      },
                      delay: 600,
                    ),

                    const SizedBox(height: 25),
                    const Text(
                      '🎯 كن بطل النقاط 🎯',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

