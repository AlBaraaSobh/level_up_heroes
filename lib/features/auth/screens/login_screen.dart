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
                      color1: AppColors.secondary,
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
                      color2: Color(0xFF4DD0E1), // سماوي مرح
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

/*


import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _contentController;
  late Animation<double> _backgroundAnimation;
  late Animation<Offset> _titleSlide;
  late Animation<double> _titleFade;

  @override
  void initState() {
    super.initState();

    // Animation controllers
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Animations
    _backgroundAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_backgroundController);

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _titleFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    ));

    // Start animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _contentController.forward();
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F23), // Dark blue
              Color(0xFF1A1A2E), // Medium dark
              Color(0xFF16213E), // Blue-grey
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated Background Elements
            _buildAnimatedBackground(),

            // Content
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Header Section
                        _buildHeader(),

                        SizedBox(height: screenHeight * 0.08),

                        // User Cards
                        _buildUserCards(),

                        SizedBox(height: screenHeight * 0.06),

                        // Footer
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating particles
            ...List.generate(6, (index) {
              final offset = _backgroundAnimation.value * 2 * 3.14159;
              return Positioned(
                left: 50 + (index * 60) + (30 * (index % 2 == 0 ? 1 : -1) *
                    (0.5 + 0.5 * (offset + index))),
                top: 100 + (index * 80) + (40 * (offset * 0.7 + index)),
                child: Container(
                  width: 4 + (index % 3),
                  height: 4 + (index % 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            }),

            // Gradient overlays
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: -150,
              left: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return SlideTransition(
      position: _titleSlide,
      child: FadeTransition(
        opacity: _titleFade,
        child: Column(
          children: [
            // Logo/Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // Title
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
              ).createShader(bounds),
              child: const Text(
                '✨ بطل النقاط ✨',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'LevelUp Heroes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.8),
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'اختر نوع المستخدم للبدء في رحلتك',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCards() {
    return Column(
      children: [
        // Parent Card
        EnhancedUserCard(
          title: 'أنا ولي أمر',
          subtitle: 'إدارة حسابات الأطفال ومتابعة التقدم',
          buttonText: 'دخول كولي أمر',
          primaryColor: AppColors.secondary,
          secondaryColor: AppColors.accent,
          icon: Icons.family_restroom_rounded,
          onTap: () {
            Navigator.pushNamed(context, '/parents_login_screen');
          },
          delay: 400,
        ),

        const SizedBox(height: 24),

        // Child Card
        EnhancedUserCard(
          title: 'أنا طفل',
          subtitle: 'الدخول إلى حسابي وجمع النقاط',
          buttonText: 'دخول كطفل',
          primaryColor: AppColors.accent,
          secondaryColor: const Color(0xFF4DD0E1),
          icon: Icons.child_care_rounded,
          onTap: () {
            Navigator.pushNamed(context, '/kids_login_screen');
          },
          delay: 700,
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return FadeTransition(
      opacity: _titleFade,
      child: Column(
        children: [
          Text(
            '🎯 كن بطل النقاط 🎯',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16),

          // Version info or additional text
          Text(
            'الإصدار 1.0.0',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

  ممكن نعملها لوضع ليلي //
class EnhancedUserCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;
  final VoidCallback onTap;
  final int delay;

  const EnhancedUserCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onTap,
    this.delay = 0,
  });

  @override
  State<EnhancedUserCard> createState() => _EnhancedUserCardState();
}

class _EnhancedUserCardState extends State<EnhancedUserCard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _hoverController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _hoverAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _hoverAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    // Start animation with delay
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    setState(() => _isHovered = hovering);
    if (hovering) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedBuilder(
            animation: _hoverAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _hoverAnimation.value,
                child: MouseRegion(
                  onEnter: (_) => _onHover(true),
                  onExit: (_) => _onHover(false),
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [
                            widget.primaryColor,
                            widget.secondaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.primaryColor.withOpacity(_isHovered ? 0.4 : 0.3),
                            blurRadius: _isHovered ? 25 : 20,
                            offset: Offset(0, _isHovered ? 12 : 8),
                            spreadRadius: _isHovered ? 2 : 0,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Icon Container
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.icon,
                              size: 40,
                              color: widget.primaryColor,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Title
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Subtitle
                          Text(
                            widget.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: widget.onTap,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: widget.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 5,
                                shadowColor: Colors.black.withOpacity(0.2),
                              ),
                              child: Text(
                                widget.buttonText,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
 */
