import 'package:flutter/material.dart';
class AvatarIcon extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final String? text;
  final double size;
  final VoidCallback? onTap;

  const AvatarIcon({
    Key? key,
    required this.color,
    this.icon,
    this.text,
    this.size = 60,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(size * 0.33), // 20px for 60px
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: Colors.white, size: size * 0.5)
              : Text(
            text ?? '',
            style: TextStyle(
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
