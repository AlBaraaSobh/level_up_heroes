import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';

class KidsPinScreen extends StatefulWidget {
  const KidsPinScreen({super.key});

  @override
  State<KidsPinScreen> createState() => _KidsPinScreenState();
}

class _KidsPinScreenState extends State<KidsPinScreen>
    with SingleTickerProviderStateMixin {
  final String _childName = "أحمد";
  final List<String> _pin = [];
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 24)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _addDigit(String digit) {
    if (_pin.length < 4) {
      setState(() => _pin.add(digit));
      if (_pin.length == 4) _validatePin();
    }
  }

  void _deleteDigit() {
    if (_pin.isNotEmpty) {
      setState(() => _pin.removeLast());
    }
  }

  void _validatePin() {
    final entered = _pin.join();
    const correctPin = "1234";

    if (entered != correctPin) {
      _shakeController.forward(from: 0);
      setState(() => _pin.clear());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ تم إدخال الرمز الصحيح!')),
      );
    }
  }

  Widget _buildPinDots() {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value - 12, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              final filled = index < _pin.length;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: filled ? AppColors.primary : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    if (filled)
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  // Widget _buildKey(String digit) {
  //   return GestureDetector(
  //     onTap: () => _addDigit(digit),
  //     child: Container(
  //       margin: const EdgeInsets.all(10),
  //       width: 72,
  //       height: 72,
  //       decoration: BoxDecoration(
  //        // color: AppColors.primary,
  //         shape: BoxShape.circle,
  //         boxShadow: [
  //           BoxShadow(
  //             color: AppColors.primary.withOpacity(0.3),
  //             blurRadius: 6,
  //             offset: const Offset(0, 4),
  //           ),
  //         ],
  //       ),
  //       child: Center(
  //         child: Text(
  //           digit,
  //           style:  TextStyle(
  //             fontSize: 26,
  //             fontWeight: FontWeight.bold,
  //            // color: Colors.black,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildKey(String digit) {
    return GestureDetector(
      onTap: () => _addDigit(digit),
      child: Container(
        margin: const EdgeInsets.all(12),
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6BA9FF), // الأزرق الفاتح
              Color(0xFF0059D4), // الأزرق الغامق
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            digit,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteKey() {
    return GestureDetector(
      onTap: _deleteDigit,
      child: Container(
        margin: const EdgeInsets.all(12),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: const Icon(Icons.backspace_outlined, color: Colors.grey, size: 26),
      ),
    );
  }


  Widget _buildKeypad() {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      [' ', '0', '<'],
    ];

    return Column(
      children: keys.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.map((key) {
            if (key == '<') return _buildDeleteKey();
            if (key == ' ') return const SizedBox(width: 84);
            return _buildKey(key);
          }).toList(),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "🔐 أدخل رمزك السري",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$_childName، جاهز للتحدي؟ 🎮',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 36),
              _buildPinDots(),
              const Spacer(),
              _buildKeypad(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
