import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';

import '../widget/add_kids_bottom_sheet.dart';
import '../widget/kids_card.dart';
import '../widget/parents_app_bar.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  List<Map<String, dynamic>> children = [
    {
      'name': 'أحمد',
      'level': 3,
      'points': 120,
      'tasksCompleted': 8,
      'achievements': 5,
      'profileColor': Colors.orange,
      'progressPercent': 0.7,
    },
    {
      'name': 'ليان',
      'level': 2,
      'points': 90,
      'tasksCompleted': 5,
      'achievements': 3,
      'profileColor': Colors.pink,
      'progressPercent': 0.5,
    },
    {
      'name': 'أحمد',
      'level': 3,
      'points': 120,
      'tasksCompleted': 8,
      'achievements': 5,
      'profileColor': Colors.orange,
      'progressPercent': 0.7,
    },
    {
      'name': 'ليان',
      'level': 2,
      'points': 90,
      'tasksCompleted': 5,
      'achievements': 3,
      'profileColor': Colors.pink,
      'progressPercent': 0.5,
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: ParentsAppBar(
        title: 'تفاصيل الأطفال',
        icon: Icons.child_care,
        onAddButtonTapped: _addChild,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final child = children[index];
                return KidsCard(
                  child: child,
                  index: index,
                  onDelete: () => _deleteChild(index),
                  onEdit: () => _editChild(index),);
              }, childCount: children.length),
            ),
          ),
        ],
      ),
    );
  }
  void _addChild() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddKidsBottomSheet(
          onChildAdded : (newChild) {
            setState(() {
              children.add(newChild);
            });
          },
        );
      },
    );
  }


  void _editChild(int index) {
    // TODO: تعديل بيانات الطفل
  }

  void _deleteChild(int index) {
    setState(() => children.removeAt(index));
  }


}