
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class KidsLoginScreen extends StatefulWidget {
  const KidsLoginScreen({super.key});

  @override
  State<KidsLoginScreen> createState() => _KidsLoginScreenState();
}

class _KidsLoginScreenState extends State<KidsLoginScreen> {
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
                  icon: const Icon(Icons.arrow_back, color: AppColors.primary),
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
                      "🦸‍♀️🦸‍♂️! مرحبًا بكم أيها الأبطال",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "اختر اسمك للدخول على حسابك والبدء في المغامرات 🏆",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
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
                          _buildChildCard(
                            name: 'أحمد',
                            level: 'بطل المستوى الثاني 🥈',
                            initial: 'أ',
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 16),
                          _buildChildCard(
                            name: 'فاطمة',
                            level: 'بطل المستوى الثاني 🥈',
                            initial: 'ف',
                            color: AppColors.accent,

                          ),
                          _buildChildCard(
                            name: 'أحمد',
                            level: 'بطل المستوى الثاني 🥈',
                            initial: 'أ',
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: تنفيذ تسجيل الدخول
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                '🎯 تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
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

  Widget _buildChildCard({
    required String name,
    required String level,
    required String initial,
    required Color color,
  }) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color,
                child: Text(
                  initial,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      level,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.star, color: Colors.amber),
            ],
          ),
        ),
      ),
    );
  }
}
