import 'package:flutter/material.dart';

class TaskTypesDistribution extends StatelessWidget {
  final Map<String, int> typeCounts;
  final int total;
  final Color Function(String) typeColor;
  final IconData Function(String) typeIcon;

  const TaskTypesDistribution({
    super.key,
    required this.typeCounts,
    required this.total,
    required this.typeColor,
    required this.typeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('توزيع أنواع المهام', Icons.pie_chart_rounded, Colors.purple),
          const SizedBox(height: 12),
          if (total == 0)
            Text(
              'لا توجد مهام ضمن الفترة المختارة.',
              style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
            )
          else
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: typeCounts.entries.map((e) {
                final perc = ((e.value / total) * 100).round();
                final color = typeColor(e.key);
                final icon = typeIcon(e.key);
                return _legendChip(label: e.key, percent: perc, color: color, icon: icon);
              }).toList(),
            ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _legendChip({
    required String label,
    required int percent,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
          const SizedBox(width: 4),
          Text('($percent%)', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
