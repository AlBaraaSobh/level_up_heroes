import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';

class ParentsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onAddButtonTapped;
  final String title;
  final IconData icon;

  const ParentsAppBar({
    super.key,
    required this.onAddButtonTapped,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Icon container
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),
          //const SizedBox(width: 20),
          // Dynamic title
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
              height: 1.2,
            ),
          ),
        //  const SizedBox(width: 20),
          // Add button
          GestureDetector(
            onTap: onAddButtonTapped,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
