import 'dart:ui';

class OnboardingModel {
  final String image;
  final String title;
  final String description;
  final Color primaryColor;
  final Color? secondaryColor;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.primaryColor,
    this.secondaryColor,
  });

}
