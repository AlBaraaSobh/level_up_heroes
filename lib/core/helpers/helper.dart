import 'package:flutter/material.dart';

class Helper {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "البريد الإلكتروني لا يمكن أن يكون فارغاً";
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (!emailRegex.hasMatch(value)) return "صيغة البريد الإلكتروني غير صحيحة";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "كلمة المرور لا يمكن أن تكون فارغة";
    if (value.length < 8) return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
    return null;
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
