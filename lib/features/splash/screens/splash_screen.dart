import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/helpers/shared_prefs_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 2)); // تأثير البداية

    final seen = await SharedPrefsHelper.hasSeenOnboarding();

    if (seen) {
      Navigator.pushReplacementNamed(context, '/login_screen');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 120), // يمكنك وضع شعار التطبيق هنا
      ),
    );
  }
}
