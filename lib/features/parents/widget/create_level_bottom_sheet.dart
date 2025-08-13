import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';
import 'package:level_up_heroes/features/parents/widget/level_input_field.dart';

import 'bottom_sheet_buttons.dart';
import 'custom_input_field.dart';

class CreateLevelBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onLevelAdded;
  final Map<String, dynamic>? level;

  const CreateLevelBottomSheet({
    super.key,
    required this.onLevelAdded,
    this.level,
  });

  @override
  State<CreateLevelBottomSheet> createState() => _CreateLevelBottomSheetState();
}

class _CreateLevelBottomSheetState extends State<CreateLevelBottomSheet> {
  late final TextEditingController _levelNameController;
  late final TextEditingController _requiredPointsController;
  late final TextEditingController _rewardNameController;
  late final TextEditingController _rewardDescriptionController;

  final List<Color> _levelColors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.red,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
  ];

  final List<IconData> _levelIcons = [
    Icons.explore_rounded,
    Icons.military_tech_rounded,
    Icons.psychology_rounded,
    Icons.star_rounded,
    Icons.diamond_rounded,
    Icons.emoji_events_rounded,
    Icons.workspace_premium_rounded,
    Icons.auto_awesome_rounded,
  ];

  late Color _selectedColor;
  late IconData _selectedIcon;
  bool _isLoading = false;
  // <--- تم تعريف isEditing هنا كمتغير حالة
  late bool isEditing;

  @override
  void initState() {
    super.initState();
    // <--- تم تهيئة isEditing في initState
    isEditing = widget.level != null;
    _levelNameController =
        TextEditingController(text: widget.level?['levelName']);
    _requiredPointsController =
        TextEditingController(text: widget.level?['requiredPoints']?.toString());
    _rewardNameController =
        TextEditingController(text: widget.level?['rewardName']);
    _rewardDescriptionController =
        TextEditingController(text: widget.level?['rewardDescription']);
    _selectedColor = widget.level?['color'] ?? _levelColors[0];
    _selectedIcon = widget.level?['icon'] ?? _levelIcons[0];
  }

  @override
  void dispose() {
    _levelNameController.dispose();
    _requiredPointsController.dispose();
    _rewardNameController.dispose();
    _rewardDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                child: Icon(
                  isEditing ? Icons.edit_rounded : Icons.add_circle_outline_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isEditing ? 'تعديل المستوى' : 'إضافة مستوى جديد',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isEditing
                    ? 'قم بتحديث معلومات المستوى الخاص بك'
                    : 'املأ المعلومات لإنشاء مستوى جديد ومميز',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF718096),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              CustomInputField(controller: _levelNameController,
                label: 'اسم المستوى',
                hint: 'مثل: المستكشف الصغير',
                icon: Icons.label_rounded,
              ),
              const SizedBox(height: 20),
              CustomInputField(controller: _requiredPointsController,
                label: 'عدد النقاط المطلوبة',
                hint: 'مثل: 100',
                icon: Icons.stars_rounded,
                keyboardType: TextInputType.number,

              ),

              const SizedBox(height: 20),
              CustomInputField(
                controller: _rewardNameController,
                label: 'اسم المكافأة',
                hint: 'مثل: شارة المستكشف',
                icon: Icons.card_giftcard_rounded,
              ),

              const SizedBox(height: 20),
              CustomInputField(
                controller: _rewardDescriptionController,
                label: 'وصف المكافأة',
                hint: 'اكتب وصفاً جميلاً للمكافأة...',
                icon: Icons.description_rounded,
                maxLines: 3,
              ),

              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'لون المستوى',
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
                    children: _levelColors.map((color) {
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
                              color: isSelected ? Colors.white : Colors.transparent,
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
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'أيقونة المستوى',
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
                    children: _levelIcons.map((icon) {
                      final isSelected = _selectedIcon == icon;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedIcon = icon),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isSelected ? _selectedColor.withOpacity(0.1) : const Color(0xFFF7FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? _selectedColor : const Color(0xFFE2E8F0),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            icon,
                            color: isSelected ? _selectedColor : const Color(0xFF718096),
                            size: 24,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              BottomSheetButtons(
                  onSave: _handleSaveLevel,
                  isLoading: false,
                  isEditing: isEditing),
            ],
          ),
        ),
      ),
    );
  }



  void _handleSaveLevel() {
    final levelName = _levelNameController.text.trim();
    final requiredPointsText = _requiredPointsController.text.trim();
    final rewardName = _rewardNameController.text.trim();
    final rewardDescription = _rewardDescriptionController.text.trim();

    if (levelName.isEmpty ||
        requiredPointsText.isEmpty ||
        rewardName.isEmpty ||
        rewardDescription.isEmpty) {
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

    final requiredPoints = int.tryParse(requiredPointsText);
    if (requiredPoints == null || requiredPoints <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('يرجى إدخال عدد نقاط صحيح'),
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

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      final levelData = {
        'levelName': levelName,
        'requiredPoints': requiredPoints,
        'rewardName': rewardName,
        'rewardDescription': rewardDescription,
        'color': _selectedColor,
        'icon': _selectedIcon,
      };
      widget.onLevelAdded(levelData);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'تم تحديث المستوى "${levelName}" بنجاح! 🎉'
                : 'تم إضافة المستوى "${levelName}" بنجاح! 🎉',
          ),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }
}