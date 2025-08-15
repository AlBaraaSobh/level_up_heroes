import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';

class TasksStats extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;

  const TasksStats({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final total = tasks.length;
    final completed = tasks.where((t) => t['isCompleted'] as bool).length;
    final pending = total - completed;

    final stats = [
      {'label': 'إجمالي المهام', 'value': total, 'icon': Icons.assignment_rounded, 'color': AppColors.primary},
      {'label': 'مكتملة', 'value': completed, 'icon': Icons.check_circle_rounded, 'color': Colors.green},
      {'label': 'معلقة', 'value': pending, 'icon': Icons.schedule_rounded, 'color': Colors.orange},
    ];

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
        children: List.generate(stats.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Container(width: 1, height: 40, color: const Color(0xFFE2E8F0));
          }
          final stat = stats[index ~/ 2];
          return Expanded(
            child: StatItem(
              label: stat['label'] as String,
              value: (stat['value'] as int).toString(),
              icon: stat['icon'] as IconData,
              color: stat['color'] as Color,
            ),
          );
        }),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const StatItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
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
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
