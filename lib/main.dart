import 'package:flutter/material.dart';
import 'package:level_up_heroes/features/auth/screens/kids_pin_screen.dart';
import 'package:level_up_heroes/features/auth/screens/kids_login_screen.dart';
import 'package:level_up_heroes/features/auth/screens/login_screen.dart';
import 'package:level_up_heroes/features/auth/screens/parents_login_screen.dart';
import 'package:level_up_heroes/features/auth/screens/parents_register_screen.dart';
import 'package:level_up_heroes/features/onboarding/screens/onboarding_screen.dart';
import 'package:level_up_heroes/features/parents/screens/parent_bottom_nav_screen.dart';

import 'features/splash/screens/splash_screen.dart';

void main() {
  runApp(const MyApp(
    initialRoute:  '/splash_screen',
  ));
}
class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'CairoPlay',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),

        ),
      ),
      initialRoute: initialRoute,
      routes: {
        '/splash_screen': (context) => const SplashScreen(),
        '/onboarding_screen' : (context) => OnboardingScreen(),
        '/login_screen' : (context) => LoginScreen(),
        '/parents_login_screen' : (context) => ParentsLoginScreen(),
        '/parents_register_screen' : (context) => ParentsRegisterScreen(),
        '/kids_login_screen' : (context) => KidsLoginScreen(),
        '/kids_pin_screen' : (context) => KidsPinScreen(),
        '/parent_bottom_nav_screen' : (context) => ParentBottomNavScreen(),
      },
    );
  }
}

