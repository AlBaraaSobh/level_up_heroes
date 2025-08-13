import 'package:flutter/material.dart';
import 'package:level_up_heroes/features/parents/widget/bottom_sheet_buttons.dart';
import 'package:level_up_heroes/features/parents/widget/custom_input_field.dart';

import '../../../core/constants/app_colors.dart';

class AddKidsBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onChildAdded;

  const AddKidsBottomSheet({super.key, required this.onChildAdded});

  @override
  State<AddKidsBottomSheet> createState() => _AddKidsBottomSheetState();
}

class _AddKidsBottomSheetState extends State<AddKidsBottomSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  String _selectedGender = 'ذكر';
  Color _selectedColor = AppColors.profileColors[0];
  late bool isEditing;

  @override
  void initState() {
    super.initState();
    isEditing = widget.onChildAdded != null;
    _nameController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.child_care_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'إضافة طفل جديد',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'أدخل معلومات طفلك لبدء رحلة التعلم',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF718096),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              CustomInputField(controller: _nameController,
                label: 'اسم الطفل',
                hint: 'أدخل اسم الطفل',
                icon: Icons.person_rounded,
              ),
              const SizedBox(height: 20),
              CustomInputField(controller: _ageController,
                label: 'العمر',
                hint: 'أدخل عمر الطفل',
                icon: Icons.person_rounded,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

              // Gender Selection
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الجنس',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildGenderOption(
                          'ذكر',
                          '👦',
                          _selectedGender == 'ذكر',
                              () => setState(() => _selectedGender = 'ذكر'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildGenderOption(
                          'أنثى',
                          '👧',
                          _selectedGender == 'أنثى',
                              () => setState(() => _selectedGender = 'أنثى'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Color Selection
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'اختر لون الملف الشخصي',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: AppColors.profileColors.map((color) {
                      final isSelected = _selectedColor == color;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = color),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? color : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: color.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                            ],
                          ),
                          child: isSelected
                              ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 20,
                          )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              const SizedBox(height: 30),

              BottomSheetButtons(
                onSave: () => onSave(),
                isLoading: false,
                isEditing: false,
              ),

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildGenderOption(String gender,
      String emoji,
      bool isSelected,
      VoidCallback onTap,) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : const Color(0xFFF7FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              gender,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primary : const Color(0xFF718096),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSave() {
    if (_nameController.text
        .trim()
        .isEmpty || _ageController.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('يرجى ملء جميع الحقول'),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    widget.onChildAdded({
      'name': _nameController.text.trim(),
      'level': 1,
      'points': 0,
      'tasksCompleted': 0,
      'achievements': 0,
      'profileColor': _selectedColor,
      'progressPercent': 0.0,
      'gender': _selectedGender,
      'age': int.tryParse(_ageController.text) ?? 0,
    });

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'تم إضافة ${_nameController.text} بنجاح! 🎉'),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}