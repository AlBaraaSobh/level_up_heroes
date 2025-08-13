import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';

class ParentsLoginScreen extends StatefulWidget {
  const ParentsLoginScreen({super.key});

  @override
  State<ParentsLoginScreen> createState() => _ParentsLoginScreenState();
}

class _ParentsLoginScreenState extends State<ParentsLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FF),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.accent),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      "👋! مرحبًا بك مجددًا",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,

                        //color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "قم بتسجيل الدخول لمتابعة إدارة حساب طفلك 👨‍👩‍👧‍👦",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: emailController,
                            label: ' البريد الإلكتروني',
                            hint: 'مثلاً: parent@email.com',
                            icon: Icons.email_outlined,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: passwordController,
                            label: ' كلمة المرور',
                            hint: 'أدخل كلمة المرور',
                            obscure: true,
                            icon: Icons.lock_outline,
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: نسيت كلمة المرور
                              },
                              child: const Text(
                                'هل نسيت كلمة المرور؟',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: تنفيذ تسجيل الدخول
                                Navigator.pushReplacementNamed(context, '/parent_bottom_nav_screen');
                              },
                              style: ElevatedButton.styleFrom(
                                //backgroundColor: AppColors.accent,
                                backgroundColor: Colors.deepPurple,

                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                '🎯 تسجيل الدخول',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'ليس لديك حساب؟',
                            style: TextStyle(color: AppColors.darkText),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/parents_register_screen');
                            },
                            child: const Text(
                              '✨ إنشاء حساب جديد',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFF7F9FC),
          prefixIcon: Icon(icon, color: AppColors.primary),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
