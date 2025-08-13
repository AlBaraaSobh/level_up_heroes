import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';
import 'package:level_up_heroes/features/parents/widget/create_level_bottom_sheet.dart';
import 'package:level_up_heroes/features/parents/widget/level_card.dart';
import 'package:level_up_heroes/features/parents/widget/parents_app_bar.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  List<Map<String, dynamic>> levels = [
    {
      'id': 1,
      'levelName': 'المستوى الأول🥇',
      'requiredPoints': 50,
      'rewardName': 'شارة المستكشف',
      'rewardDescription': 'شارة ذهبية جميلة للمستكشف الصغير مع دبوس خاص',
      'color': Colors.green,
      'icon': Icons.explore_rounded,
    },
    {
      'id': 2,
      'levelName': 'المستوى الثاني🥈',
      'requiredPoints': 120,
      'rewardName': 'سيف المعرفة',
      'rewardDescription': 'سيف خشبي مزين بالنجوم كرمز للقوة والمعرفة',
      'color': Colors.blue,
      'icon': Icons.military_tech_rounded,
    },
    {
      'id': 3,
      'levelName': 'المستوى الثالث🥉',
      'requiredPoints': 250,
      'rewardName': 'تاج الحكمة',
      'rewardDescription': 'تاج ذهبي رائع مرصع بالجواهر للحكيم الصغير',
      'color': Colors.purple,
      'icon': Icons.psychology_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: ParentsAppBar(
        title: 'المكافآت والمستويات',
        icon: Icons.emoji_events_rounded,
        onAddButtonTapped: _showCreateLevelBottomSheet,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];
          return LevelCard(
            level: level,
            onEdit: () => _editLevel(index),
            onDelete: () => _deleteLevel(index),
          );
        },
      ),
    );
  }

  void _showCreateLevelBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CreateLevelBottomSheet(
        onLevelAdded: (Map<String, dynamic> newLevel) {
          setState(() {
            newLevel['id'] = levels.length + 1;
            levels.add(newLevel);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم إضافة ${newLevel['levelName']} بنجاح! 🎉'),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }

  void _editLevel(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CreateLevelBottomSheet(
        level: levels[index],
        onLevelAdded: (Map<String, dynamic> updatedLevel) {
          setState(() {
            levels[index] = {...levels[index], ...updatedLevel};
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم تحديث ${updatedLevel['levelName']} بنجاح! ✨'),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }

  void _deleteLevel(int index) {
    final levelName = levels[index]['levelName'];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.orange, size: 28),
            SizedBox(width: 12),
            Text('تأكيد الحذف'),
          ],
        ),
        content: Text('هل أنت متأكد من حذف "$levelName"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => levels.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم حذف $levelName'),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(16),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
