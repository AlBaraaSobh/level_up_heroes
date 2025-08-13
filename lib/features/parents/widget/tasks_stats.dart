import 'package:flutter/material.dart';

class TasksStats extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;

  const TasksStats({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final total = tasks.length;
    final completed = tasks.where((t) => t['isCompleted']).length;
    final pending = tasks.where((t) => !t['isCompleted']).length;

    Widget statItem(String title, String value, IconData icon, Color color) {
      return Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A202C),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: statItem('إجمالي المهام', '$total', Icons.assignment_rounded, Colors.blue)),
          Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
          Expanded(child: statItem('مكتملة', '$completed', Icons.check_circle_rounded, Colors.green)),
          Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
          Expanded(child: statItem('معلقة', '$pending', Icons.schedule_rounded, Colors.orange)),
        ],
      ),
    );
  }
}
