import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';
import 'package:level_up_heroes/features/parents/widgets/bottom_sheet_buttons.dart';
import 'package:level_up_heroes/features/parents/widgets/level_input_field.dart';

import 'custom_input_field.dart'; // تأكد من وجود هذا الملف أو أضف دالة مشابهة له

class CreateTaskBottomSheet extends StatefulWidget {
  final Map<String, dynamic>? task;
  final List<Map<String, dynamic>> children;
  final Function(Map<String, dynamic>) onTaskAdded;

  const CreateTaskBottomSheet({
    super.key,
    this.task,
    required this.children,
    required this.onTaskAdded,
  });

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pointsController = TextEditingController();

  String selectedType = 'دراسية';
  List<int> selectedChildren = [];
  Color selectedColor = Colors.blue;
  IconData selectedIcon = Icons.school_rounded;

  final List<Map<String, dynamic>> taskTypes = [
    {
      'name': 'دراسية',
      'color': Colors.blue,
      'icon': Icons.school_rounded,
    },
    {
      'name': 'منزلية',
      'color': Colors.orange,
      'icon': Icons.home_rounded,
    },
    {
      'name': 'تطوير ذات',
      'color': Colors.green,
      'icon': Icons.psychology_rounded,
    },
    {
      'name': 'رياضية',
      'color': Colors.red,
      'icon': Icons.fitness_center_rounded,
    },
    {
      'name': 'اجتماعية',
      'color': Colors.purple,
      'icon': Icons.people_rounded,
    },
    {
      'name': 'إبداعية',
      'color': Colors.pink,
      'icon': Icons.palette_rounded,
    },
    {
      'name': 'تقنية',
      'color': Colors.teal,
      'icon': Icons.computer_rounded,
    },
    {
      'name': 'أخرى',
      'color': Colors.grey,
      'icon': Icons.star_rounded,
    },
  ];

  bool get isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _initializeForEditing();
    }
  }

  void _initializeForEditing() {
    final task = widget.task!;
    _titleController.text = task['title'];
    _descriptionController.text = task['description'];
    _pointsController.text = task['points'].toString();
    selectedType = task['type'];
    selectedChildren = List<int>.from(task['assignedChildren']);
    selectedColor = task['color'];
    selectedIcon = task['icon'];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // تحديد ارتفاع ثابت مع الأخذ في الاعتبار لوحة المفاتيح
      height: MediaQuery.of(context).size.height * 0.85,
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 28,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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

                child: Icon(
                  isEditing ? Icons.edit_rounded : Icons.add_circle_outline_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isEditing ? 'تعديل المهمة' : 'إضافة مهمة جديدة',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isEditing
                    ? 'قم بتحديث معلومات المهمة'
                    : 'املأ المعلومات لإنشاء مهمة جديدة للأطفال',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF718096),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputField(
                      controller: _titleController,
                      label: 'عنوان المهمة',
                      hint: 'مثال: حل واجب الرياضيات',
                      icon: Icons.title_rounded,
                    ),

                    const SizedBox(height: 20),

                    CustomInputField(
                      controller: _pointsController,
                      label: 'عدد النقاط',
                      hint: 'مثال: 25',
                      icon: Icons.star_rounded,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      controller: _descriptionController,
                      label: 'وصف المهمة',
                      hint: 'اكتب وصفاً مفصلاً للمهمة...',
                      icon: Icons.description_rounded,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 20),

                    // Task Type
                    _buildSectionTitle('نوع المهمة', Icons.category_rounded),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 65,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: taskTypes.length,
                        itemBuilder: (context, index) {
                          final type = taskTypes[index];
                          final isSelected = selectedType == type['name'];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedType = type['name'];
                                selectedColor = type['color'];
                                selectedIcon = type['icon'];
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? selectedColor.withOpacity(0.1) : const Color(0xFFF7FAFC),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected ? selectedColor : const Color(0xFFE2E8F0),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    type['icon'],
                                    color: isSelected ? type['color'] : const Color(0xFF64748B),
                                    size: 20,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    type['name'],
                                    style: TextStyle(
                                      color: isSelected ? type['color'] : const Color(0xFF64748B),
                                      fontSize: 12,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Assigned Children
                    _buildSectionTitle('الأطفال المُكلفون', Icons.people_rounded),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'اختر الأطفال الذين ستُوجه لهم هذه المهمة:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: widget.children.map((child) {
                              final isSelected = selectedChildren.contains(child['id']);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedChildren.remove(child['id']);
                                    } else {
                                      selectedChildren.add(child['id']);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? selectedColor.withOpacity(0.1) : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected ? selectedColor : const Color(0xFFE2E8F0),
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        child['avatar'],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        child['name'],
                                        style: TextStyle(
                                          color: isSelected ? selectedColor : const Color(0xFF475569),
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                        ),
                                      ),
                                      if (isSelected) ...[
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.check_circle_rounded,
                                          color: selectedColor,
                                          size: 16,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          if (selectedChildren.isEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.orange.withOpacity(0.3)),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.warning_rounded, color: Colors.orange, size: 16),
                                  SizedBox(width: 8),
                                  Text(
                                    'يجب اختيار طفل واحد على الأقل',
                                    style: TextStyle(color: Colors.orange, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              BottomSheetButtons(onSave: _saveTask, isLoading: false, isEditing: isEditing),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: selectedColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: selectedColor,
          ),
        ),
      ],
    );
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedChildren.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب اختيار طفل واحد على الأقل لتوجيه المهمة إليه'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final taskData = {
      'title': _titleController.text.trim(),
      'type': selectedType,
      'points': int.parse(_pointsController.text),
      'description': _descriptionController.text.trim(),
      'assignedChildren': List<int>.from(selectedChildren),
      'color': selectedColor,
      'icon': selectedIcon,
    };

    widget.onTaskAdded(taskData);
    Navigator.pop(context);
  }
}