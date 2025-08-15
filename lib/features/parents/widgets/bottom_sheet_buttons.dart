import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
class BottomSheetButtons extends StatelessWidget {
  final VoidCallback onSave;
  final bool isLoading;
  final bool isEditing;
  final String? saveText;
  final IconData? saveIcon;

  const BottomSheetButtons({
    super.key,
    required this.onSave,
    required this.isLoading,
    required this.isEditing,
    this.saveText,
    this.saveIcon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonText = saveText ?? (isEditing ? 'حفظ التغييرات' : 'حفظ');

    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: const Color(0xFF718096).withOpacity(0.3),
                ),
              ),
            ),
            child: const Text(
              'إلغاء',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF718096)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: isLoading
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (saveIcon != null) ...[
                  Icon(saveIcon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  buttonText,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
