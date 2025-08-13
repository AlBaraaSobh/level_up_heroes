import 'package:flutter/material.dart';
import 'task_card.dart';

class TasksList extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  final List<Map<String, dynamic>> children;
  final void Function(int) onEdit;
  final void Function(int) onDelete;
  final void Function(int) onToggleComplete;

  const TasksList({
    super.key,
    required this.tasks,
    required this.children,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.task_alt_rounded,
                size: 60,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'لا توجد مهام',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'ابدأ بإضافة مهمة جديدة للأطفال',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          children: children,
          onEdit: () => onEdit(index),
          onDelete: () => onDelete(index),
          onToggleComplete: () => onToggleComplete(index),
        );
      },
    );
  }
}
