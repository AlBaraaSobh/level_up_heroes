import 'package:flutter/material.dart';

class RecentAchievements extends StatelessWidget {
  final List<Map<String, dynamic>> recent;
  final String Function(DateTime) relativeTime;

  const RecentAchievements({super.key, required this.recent, required this.relativeTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _sectionHeader('آخر الإنجازات', Icons.emoji_events_rounded, Colors.amber),
          ),
          if (recent.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'لا توجد إنجازات حديثة.',
                style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
              ),
            )
          else
            ...recent.map((t) => _achievementTile(t)).toList(),
        ],
      ),
    );
  }

  Widget _achievementTile(Map<String, dynamic> t) {
    final title = t['title'] as String;
    final points = t['points'] as int;
    final completedAt = t['completedAt'] as DateTime;
    final color = t['color'] as Color;
    final when = relativeTime(completedAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.star_rounded, color: color, size: 20),
        ),
        title: Text(
          '$title (+$points)',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          when,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 16),
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
}
