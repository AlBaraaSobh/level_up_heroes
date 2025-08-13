import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingModel model;

  const OnboardingPage({super.key, required this.model});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); //  تكرار الأنيميشن ذهاباً وإياباً

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.model.primaryColor,
            widget.model.secondaryColor ?? widget.model.primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -_animation.value), // ⬆️⬇️
                    child: child,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      widget.model.image,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                widget.model.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.model.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// import '../models/onboarding_model.dart';
//
// class OnboardingPage extends StatelessWidget {
//   final OnboardingModel model;
//
//   const OnboardingPage({super.key, required this.model});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body : Container(
//         width: double.infinity,
//         height:  double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [
//             model.primaryColor,
//             model.secondaryColor ?? model.primaryColor
//            // Color()
//           ],
//             begin: Alignment.topLeft,
//             end:  Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(model.image, height: 250),
//             const SizedBox(height: 24),
//             Text(model.title,),
//             const SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Text(
//                 model.description,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
