import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helpers/shared_prefs_helper.dart';
import '../models/onboarding_model.dart';
import '../widget/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: 'assets/images/onboarding-welcome.jpg',
      title: 'أهلاً بك في طفلي البطل',
      description: 'تطبيق ممتع يحول المهام اليومية إلى مغامرات شيقة لطفلك الصغير 🦸‍♂️✨',
      primaryColor: AppColors.accent,
    ),
    OnboardingModel(
      image: 'assets/images/onboarding-tasks.jpg',
      title: 'الوالدين يحددون المهام',
      description: 'أضف مهام يومية لطفلك واتركه يكتشف متعة الإنجاز والمسؤولية ✅📋',
      primaryColor: AppColors.primary,
      secondaryColor: AppColors.danger,
    ),
    OnboardingModel(
      image: 'assets/images/onboarding-rewards.jpg',
      title: 'اجمع النقاط واحصل على الجوائز',
      description: 'كل مهمة مكتملة تعني نقاط أكثر وجوائز رائعة تنتظر طفلك 🌟🎁',
      primaryColor: AppColors.secondary,
      secondaryColor: AppColors.accent,
    ),
    OnboardingModel(
      image: 'assets/images/onboarding-motivation.jpg',
      title: 'كل يوم فرصة جديدة لتكون البطل!',
      description: 'ابدأ رحلة ممتعة مع طفلك نحو بناء عادات إيجابية تدوم مدى الحياة 🚀💖',
      primaryColor: AppColors.accent,
    ),
  ];

  void nextPage() async {
    if (currentIndex < pages.length - 1) {
      controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      await SharedPrefsHelper.setOnboardingSeen();
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  void skip() async {
    await SharedPrefsHelper.setOnboardingSeen();
    Navigator.pushReplacementNamed(context, '/login_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return OnboardingPage(model: pages[index]);
            },
          ),

          // زر التخطي
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: skip,
              child: const Text(
                'تخطي',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          // المؤشر وزر التالي
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white54,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 8,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(currentIndex < pages.length - 1 ? 'التالي' : 'ابدأ الآن'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:level_up_heroes/core/constants/app_colors.dart';
//
// import '../models/onboarding_model.dart';
// import '../widget/onboarding_page.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//    final controller = PageController();
//     int currentIndex = 0 ;
//
// final List<OnboardingModel> pages = [
//   OnboardingModel(
//     image: 'assets/images/onboarding-welcome.jpg',
//     title: 'أهلاً بك في طفلي البطل',
//     description: 'تطبيق ممتع يحول المهام اليومية إلى مغامرات شيقة لطفلك الصغير',
//      primaryColor: AppColors.accent,
//   ),
//   OnboardingModel(
//     image: 'assets/images/onboarding-tasks.jpg',
//     title: 'الوالدين يحددون المهام',
//     description: 'أضف مهام يومية لطفلك واتركه يكتشف متعة الإنجاز والمسؤولية',
//     primaryColor: AppColors.primary,
//     secondaryColor: AppColors.danger,
//
//   ),
//   OnboardingModel(
//     image: 'assets/images/onboarding-rewards.jpg',
//     title: 'اجمع النقاط واحصل على الجوائز!',
//     description: 'كل مهمة مكتملة تعني نقاط أكثر وجوائز رائعة تنتظر طفلك',
//     primaryColor: AppColors.secondary,
//     secondaryColor: AppColors.accent
//   ),
//   OnboardingModel(
//     image: 'assets/images/onboarding-motivation.jpg',
//     title: 'كل يوم فرصة جديدة لتكون البطل!',
//     description: 'ابدأ رحلة ممتعة مع طفلك نحو بناء عادات إيجابية تدوم مدى الحياة',
//     primaryColor: AppColors.accent,
//   ),
// ];
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//       controller: controller,
//       onPageChanged: (index) {
//         setState(() => currentIndex = index);
//       },
//       itemCount: pages.length,
//       itemBuilder: (context, index) {
//         return OnboardingPage(model: pages[index]);
//       },
//     ),
//
//     );
//   }
// }
