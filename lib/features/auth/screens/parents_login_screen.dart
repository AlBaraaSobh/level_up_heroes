import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';
import 'package:level_up_heroes/features/parents/screens/parent_bottom_nav_screen.dart';
import '../../../core/helpers/helper.dart';
import '../widget/auth_action_button.dart';
import '../widget/auth_header.dart';
import 'parents_register_screen.dart';
import '../widget/auth_text_field.dart';

class ParentsLoginScreen extends StatefulWidget {
  const ParentsLoginScreen({super.key});

  @override
  State<ParentsLoginScreen> createState() => _ParentsLoginScreenState();
}

class _ParentsLoginScreenState extends State<ParentsLoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

   // await Future.delayed(const Duration(seconds: 2)); // محاكاة استدعاء API

    setState(() => _isLoading = false);

    Helper.showMessage(context, "تم تسجيل الدخول بنجاح ✅");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ParentBottomNavScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const AuthHeader(
                    title: '"مرحباً بك مجدداً! 👋"',
                    subtitle: 'سجل دخولك لمتابعة إدارة حسابات الأطفال',
                  ),
                  const SizedBox(height: 40),
                  _buildFormCard(),
                  const SizedBox(height: 20),
                  _buildRegisterButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
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
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AuthTextField(
              controller: _emailController,
              label: "البريد الإلكتروني",
              hint: "parent@email.com",
              keyboardType: TextInputType.emailAddress,
              validator: Helper.validateEmail,
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: _passwordController,
              label: "كلمة المرور",
              hint: "أدخل كلمة المرور",
              isPassword: true,
              showVisibilityIcon: true,
              validator: Helper.validatePassword,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 24),
            AuthActionButton(
              onPressed: _login,
              textBtn: '🚀 تسجيل الدخول',
              isLoading: _isLoading,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("ليس لديك حساب؟ ",
            style: TextStyle(color: Colors.grey, fontSize: 14)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ParentsRegisterScreen()),
            );
          },
          child: const Text(
            "إنشاء حساب جديد",
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
