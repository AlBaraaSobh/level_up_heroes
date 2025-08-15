import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';
import '../widgets/parents_app_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/tasks_filter.dart';
import '../widgets/tasks_stats.dart';
import '../widgets/tasks_list.dart';
import '../widgets/create_task_bottom_sheet.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Map<String, dynamic>> children = [
    {'id': 1, 'name': 'أحمد', 'avatar': '👦'},
    {'id': 2, 'name': 'فاطمة', 'avatar': '👧'},
    {'id': 3, 'name': 'محمد', 'avatar': '🧒'},
    {'id': 4, 'name': 'نور', 'avatar': '👧'},
  ];

  List<Map<String, dynamic>> tasks = [
    {
      'id': 1,
      'title': 'حل واجب الرياضيات',
      'type': 'دراسية',
      'points': 25,
      'description': 'حل جميع المسائل في الصفحة 45 من كتاب الرياضيات',
      'assignedChildren': [1, 2],
      'color': Colors.blue,
      'icon': Icons.calculate_rounded,
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'id': 2,
      'title': 'ترتيب الغرفة',
      'type': 'منزلية',
      'points': 15,
      'description': 'ترتيب السرير وتنظيم الألعاب في الخزانة',
      'assignedChildren': [3],
      'color': Colors.orange,
      'icon': Icons.cleaning_services_rounded,
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 3,
      'title': 'قراءة 30 دقيقة',
      'type': 'تطوير ذات',
      'points': 20,
      'description': 'قراءة أي كتاب مفيد لمدة 30 دقيقة متواصلة',
      'assignedChildren': [1, 3, 4],
      'color': Colors.green,
      'icon': Icons.menu_book_rounded,
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
    },
    {
      'id': 4,
      'title': 'ممارسة التمارين',
      'type': 'رياضية',
      'points': 30,
      'description': 'ممارسة التمارين الرياضية لمدة 20 دقيقة',
      'assignedChildren': [2, 4],
      'color': Colors.red,
      'icon': Icons.fitness_center_rounded,
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(minutes: 30)),
    },
  ];

  String selectedFilter = 'الكل';
  final List<String> filterOptions = ['الكل', 'مكتملة', 'المعلقة'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: ParentsAppBar(
        title: 'ادارة المهام',
        icon: Icons.task_alt_rounded,
        onAddButtonTapped: _showCreateTaskBottomSheet,
      ),
      body: Column(
        children: [
          TasksFilter(
            filterOptions: filterOptions,
            selectedFilter: selectedFilter,
            onFilterChanged: (val) {
              setState(() {
                selectedFilter = val;
              });
            },
          ),
          TasksStats(
            tasks: tasks,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TasksList(
              tasks: filteredTasks,
              children: children,
              onEdit: _editTask,
              onDelete: _deleteTask,
              onToggleComplete: _toggleTaskCompletion,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredTasks {
    if (selectedFilter == 'الكل') return tasks;
    if (selectedFilter == 'مكتملة') {
      return tasks.where((t) => t['isCompleted']).toList();
    }
    if (selectedFilter == 'المعلقة') {
      return tasks.where((t) => !t['isCompleted']).toList();
    }
    return tasks.where((t) => t['type'] == selectedFilter).toList();
  }

  void _showCreateTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CreateTaskBottomSheet(
        children: children,
        onTaskAdded: (newTask) {
          setState(() {
            newTask['id'] = tasks.length + 1;
            newTask['isCompleted'] = false;
            newTask['createdAt'] = DateTime.now();
            tasks.insert(0, newTask);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم إضافة مهمة "${newTask['title']}" بنجاح! 🎉'),
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

  void _editTask(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CreateTaskBottomSheet(
        task: tasks[index],
        children: children,
        onTaskAdded: (updatedTask) {
          setState(() {
            tasks[index] = {...tasks[index], ...updatedTask};
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم تحديث مهمة "${updatedTask['title']}" بنجاح! ✨'),
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

  void _deleteTask(int index) {
    final taskTitle = tasks[index]['title'];
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
        content: Text('هل أنت متأكد من حذف مهمة "$taskTitle"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => tasks.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم حذف مهمة "$taskTitle"'),
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

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index]['isCompleted'] = !tasks[index]['isCompleted'];
    });

    final taskTitle = tasks[index]['title'];
    final isCompleted = tasks[index]['isCompleted'];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCompleted
              ? 'تم تمييز "$taskTitle" كمكتملة! 🎉'
              : 'تم إلغاء إكمال "$taskTitle"',
        ),
        backgroundColor: isCompleted ? Colors.green : Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
