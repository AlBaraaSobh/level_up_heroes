import 'package:flutter/material.dart';

class BehaviorInsights extends StatelessWidget {
  final String childName;
  final int? rank;
  final Map<String, int> typeCounts;
  final String bestTime;
  final double completionRate;
  final Duration? avgDuration;

  const BehaviorInsights({
    super.key,
    required this.childName,
    required this.rank,
    required this.typeCounts,
    required this.bestTime,
    required this.completionRate,
    required this.avgDuration,
  });

  @override
  Widget build(BuildContext context) {
    final topType = typeCounts.isEmpty
        ? '-'
        : (typeCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
        .first
        .key;

    final tips = <String>[
      if (rank != null) 'ترتيب $childName بين إخوته: #$rank ضمن الفترة المختارة.',
      'أفضل وقت لإنجاز المهام: $bestTime.',
      'أكثر نوع مهام نشاطًا: $topType.',
      if (completionRate < 50)
        'نسبة الإنجاز منخفضة؛ جرّب تقسيم المهام الكبيرة إلى خطوات أصغر.',
      if (avgDuration != null && avgDuration!.inMinutes > 120)
        'متوسط الوقت لإكمال المهمة مرتفع؛ فكّر في مهام أقصر بنقاط أقل لرفع الحافز.',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('لمحة سلوكية', Icons.insights_rounded, Colors.indigo),
          const SizedBox(height: 10),
          ...tips.map((t) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_outline, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    t,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )),
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
}
