import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textBtn;
  final bool isLoading;

  const AuthActionButton({
    super.key,
    required this.onPressed,
    required this.textBtn,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Text(textBtn , style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      );
  }
}
