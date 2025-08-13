import 'package:flutter/material.dart';
import 'package:level_up_heroes/features/parents/widget/parents_app_bar.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with TickerProviderStateMixin {
  // ----- بيانات وهمية (اربطها لاحقًا بمصدر بياناتك) -----
  final List<Map<String, dynamic>> _children = [
    {'id': 1, 'name': 'أحمد', 'avatar': '👦', 'color': Colors.blue},
    {'id': 2, 'name': 'ليان', 'avatar': '👧', 'color': Colors.pink},
    {'id': 3, 'name': 'محمد', 'avatar': '🧒', 'color': Colors.green},
  ];

  // يحتوي على createdAt / completedAt لحساب السرعة ونسبة الإنجاز
  final List<Map<String, dynamic>> _tasks = [
    // أحمد
    {
      'id': 1,
      'title': 'حل واجب الرياضيات',
      'type': 'دراسية',
      'points': 25,
      'assignedChildren': [1],
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 2, hours: 6)),
      'completedAt': DateTime.now().subtract(const Duration(days: 2, hours: 3)),
      'icon': Icons.calculate_rounded,
      'color': Colors.blue,
    },
    {
      'id': 2,
      'title': 'قراءة 30 دقيقة',
      'type': 'تطوير',
      'points': 20,
      'assignedChildren': [1, 2],
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 1, hours: 8)),
      'completedAt': DateTime.now().subtract(const Duration(days: 1, hours: 7)),
      'icon': Icons.menu_book_rounded,
      'color': Colors.green,
    },
    {
      'id': 3,
      'title': 'ترتيب الغرفة',
      'type': 'منزلية',
      'points': 15,
      'assignedChildren': [1],
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(hours: 10)),
      'completedAt': null,
      'icon': Icons.cleaning_services_rounded,
      'color': Colors.orange,
    },

    // ليان
    {
      'id': 4,
      'title': 'ممارسة التمارين',
      'type': 'رياضية',
      'points': 30,
      'assignedChildren': [2],
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 3, hours: 9)),
      'completedAt': DateTime.now().subtract(const Duration(days: 3, hours: 8)),
      'icon': Icons.fitness_center_rounded,
      'color': Colors.red,
    },
    {
      'id': 5,
      'title': 'قراءة 30 دقيقة',
      'type': 'تطوير',
      'points': 20,
      'assignedChildren': [2],
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(hours: 20)),
      'completedAt': null,
      'icon': Icons.menu_book_rounded,
      'color': Colors.green,
    },

    // محمد
    {
      'id': 6,
      'title': 'واجب العلوم',
      'type': 'دراسية',
      'points': 25,
      'assignedChildren': [3],
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 6, hours: 5)),
      'completedAt': DateTime.now().subtract(const Duration(days: 6, hours: 1)),
      'icon': Icons.science_rounded,
      'color': Colors.blue,
    },
    {
      'id': 7,
      'title': 'ترتيب الألعاب',
      'type': 'منزلية',
      'points': 10,
      'assignedChildren': [3],
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 1, hours: 6)),
      'completedAt': DateTime.now().subtract(const Duration(days: 1, hours: 4)),
      'icon': Icons.home_rounded,
      'color': Colors.orange,
    },
  ];

  // ----- حالة الشاشة -----
  int? _selectedChildId; // null = الكل
  String _selectedPeriod = 'أسبوعي';
  final List<String> _periodOptions = ['أسبوعي', 'شهري', 'سنوي'];

  late AnimationController _anim;
  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  // ----- أدوات مساعدة للفلترة والحساب -----
  DateTime get _periodStart {
    final now = DateTime.now();
    switch (_selectedPeriod) {
      case 'سنوي':
        return now.subtract(const Duration(days: 365));
      case 'شهري':
        return now.subtract(const Duration(days: 30));
      default:
        return now.subtract(const Duration(days: 7));
    }
  }

  List<Map<String, dynamic>> _tasksFor({int? childId}) {
    return _tasks.where((t) {
      final inPeriod = (t['createdAt'] as DateTime).isAfter(_periodStart) ||
          (t['completedAt'] != null &&
              (t['completedAt'] as DateTime).isAfter(_periodStart));
      final forChild =
      childId == null ? true : (t['assignedChildren'] as List).contains(childId);
      return inPeriod && forChild;
    }).toList();
  }

  Map<String, dynamic> _metrics({int? childId}) {
    final tasks = _tasksFor(childId: childId);
    final completed = tasks.where((t) => t['isCompleted'] == true).toList();
    final assignedCount = tasks.length;
    final completedCount = completed.length;

    final totalPoints = completed.fold<int>(0, (sum, t) => sum + (t['points'] as int));

    // معدل الإنجاز
    final completionRate =
    assignedCount == 0 ? 0.0 : (completedCount / assignedCount) * 100;

    // متوسط سرعة الإنجاز (فرق الوقت بين الإنشاء والإكمال بالدقائق)
    final speeds = completed
        .map<int>((t) =>
    (t['completedAt'] as DateTime)
        .difference(t['createdAt'] as DateTime)
        .inMinutes)
        .toList();
    final avgMinutes =
    speeds.isEmpty ? null : (speeds.reduce((a, b) => a + b) / speeds.length);
    final avgDuration = avgMinutes == null
        ? null
        : Duration(minutes: avgMinutes.round());

    // أفضل سلسلة أيام إنجاز (أطول streak)
    final dates = completed
        .where((t) => t['completedAt'] != null)
        .map<DateTime>((t) => DateTime(
      (t['completedAt'] as DateTime).year,
      (t['completedAt'] as DateTime).month,
      (t['completedAt'] as DateTime).day,
    ))
        .toSet()
        .toList()
      ..sort();
    int bestStreak = 0;
    int currentStreak = 0;
    for (int i = 0; i < dates.length; i++) {
      if (i == 0) {
        currentStreak = 1;
        bestStreak = 1;
      } else {
        final diff = dates[i].difference(dates[i - 1]).inDays;
        if (diff == 1) {
          currentStreak++;
        } else if (diff > 1) {
          currentStreak = 1;
        }
        if (currentStreak > bestStreak) bestStreak = currentStreak;
      }
    }

    // أفضل وقت إنجاز (صباح/بعد الظهر/مساء)
    String bestTime = '-';
    if (completed.isNotEmpty) {
      final buckets = {'صباح': 0, 'بعد الظهر': 0, 'مساء': 0};
      for (final t in completed) {
        final h = (t['completedAt'] as DateTime).hour;
        if (h >= 6 && h < 12) buckets['صباح'] = buckets['صباح']! + 1;
        else if (h >= 12 && h < 18) buckets['بعد الظهر'] = buckets['بعد الظهر']! + 1;
        else buckets['مساء'] = buckets['مساء']! + 1;
      }
      bestTime = buckets.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    }

    // توزيع أنواع المهام
    final Map<String, int> typeCounts = {};
    for (final t in tasks) {
      final type = (t['type'] as String);
      typeCounts[type] = (typeCounts[type] ?? 0) + 1;
    }

    // ترتيب الطفل (Leaderboard) بحسب النقاط ضمن الفترة
    int? rank;
    if (childId != null) {
      final totals = <int, int>{};
      for (final c in _children) {
        final cid = c['id'] as int;
        final pts = _tasksFor(childId: cid)
            .where((t) => t['isCompleted'] == true)
            .fold<int>(0, (sum, t) => sum + (t['points'] as int));
        totals[cid] = pts;
      }
      final sorted = totals.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      rank = sorted.indexWhere((e) => e.key == childId) + 1;
    }

    return {
      'totalPoints': totalPoints,
      'completionRate': completionRate, // %
      'avgDuration': avgDuration, // Duration?
      'bestStreak': bestStreak,
      'bestTime': bestTime,
      'typeCounts': typeCounts,
      'assignedCount': assignedCount,
      'completedCount': completedCount,
      'rank': rank,
    };
  }

  List<Map<String, dynamic>> _recentAchievements({int? childId}) {
    final completed = _tasksFor(childId: childId)
        .where((t) => t['isCompleted'] == true && t['completedAt'] != null)
        .toList()
      ..sort((a, b) =>
          (b['completedAt'] as DateTime).compareTo(a['completedAt'] as DateTime));
    return completed.take(5).toList();
  }

  // ----- واجهة المستخدم -----
  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFF8FAFF);

    final metrics = _metrics(childId: _selectedChildId);
    final recent = _recentAchievements(childId: _selectedChildId);

    return Scaffold(
      backgroundColor: bg,
      appBar: ParentsAppBar(
        title: 'التقارير والإحصائيات',
        icon: Icons.bar_chart_rounded,
        onAddButtonTapped: _exportReport,
      ),
      body: AnimatedBuilder(
        animation: _anim,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildChildSelector(),
              const SizedBox(height: 12),
              _buildPeriodFilter(),
              const SizedBox(height: 20),
              _buildStatsGrid(metrics),
              const SizedBox(height: 20),
              _buildBehaviorInsights(metrics),
              const SizedBox(height: 20),
              if (_selectedChildId == null)
                _buildFamilyPointsComparison()
              else
                _buildTaskTypesDistribution(metrics),
              const SizedBox(height: 20),
              _buildRecentAchievements(recent),
              const SizedBox(height: 20),
              _buildExportButton(),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }

  // اختيار الطفل (الكل + الأطفال)
  Widget _buildChildSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: _cardDecoration(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _childChip(
              label: 'الكل',
              icon: Icons.group_rounded,
              color: Colors.blue,
              selected: _selectedChildId == null,
              onTap: () {
                setState(() => _selectedChildId = null);
                _anim
                  ..reset()
                  ..forward();
              },
            ),
            const SizedBox(width: 8),
            ..._children.map((c) {
              final id = c['id'] as int;
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: _childChip(
                  label: c['name'] as String,
                  emoji: c['avatar'] as String,
                  color: c['color'] as Color,
                  selected: _selectedChildId == id,
                  onTap: () {
                    setState(() => _selectedChildId = id);
                    _anim
                      ..reset()
                      ..forward();
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _childChip({
    required String label,
    String? emoji,
    IconData? icon,
    required Color color,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            if (emoji != null)
              Text(emoji, style: const TextStyle(fontSize: 16))
            else if (icon != null)
              Icon(icon, size: 18, color: color)
            else
              const SizedBox.shrink(),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? color : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // فلتر الفترة
  Widget _buildPeriodFilter() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _periodOptions.map((option) {
          final isSelected = _selectedPeriod == option;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedPeriod = option);
                _anim
                  ..reset()
                  ..forward();
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color:
                      isSelected ? Colors.blue : Colors.grey.shade300),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // شبكة الإحصائيات الرئيسية
  Widget _buildStatsGrid(Map<String, dynamic> m) {
    final items = [
      {
        'title': 'إجمالي النقاط',
        'value': '${m['totalPoints']}',
        'icon': Icons.stars_rounded,
        'color': Colors.blue
      },
      {
        'title': 'نسبة الإنجاز',
        'value': '${m['completionRate'].toStringAsFixed(0)}%',
        'icon': Icons.task_alt_rounded,
        'color': Colors.green
      },
      {
        'title': 'متوسط سرعة الإنجاز',
        'value': _formatDuration(m['avgDuration']),
        'icon': Icons.speed_rounded,
        'color': Colors.orange
      },
      {
        'title': 'أفضل سلسلة أيام',
        'value': '${m['bestStreak']} يوم',
        'icon': Icons.local_fire_department_rounded,
        'color': Colors.red
      },
    ];

    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 110,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, i) {
        final it = items[i];
        return _statCard(
          title: it['title'] as String,
          value: it['value'] as String,
          icon: it['icon'] as IconData,
          color: it['color'] as Color,
        );
      },
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // لمحة سلوكية ذكية
  Widget _buildBehaviorInsights(Map<String, dynamic> m) {
    final rank = m['rank'] as int?;
    final childName = _selectedChildId == null
        ? 'العائلة'
        : _children.firstWhere((c) => c['id'] == _selectedChildId)['name'] as String;

    final typeCounts = (m['typeCounts'] as Map<String, int>);
    final topType = typeCounts.isEmpty
        ? '-'
        : (typeCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)))
        .first
        .key;

    final tips = <String>[
      if (_selectedChildId != null && rank != null)
        'ترتيب $childName بين إخوته: #$rank ضمن الفترة المختارة.',
      'أفضل وقت لإنجاز المهام: ${m['bestTime']}.',
      'أكثر نوع مهام نشاطًا: $topType.',
      if (m['completionRate'] < 50)
        'نسبة الإنجاز منخفضة؛ جرّب تقسيم المهام الكبيرة إلى خطوات أصغر.',
      if (m['avgDuration'] is Duration && (m['avgDuration'] as Duration).inMinutes > 120)
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

  // مقارنة نقاط العائلة (للـ "الكل")
  Widget _buildFamilyPointsComparison() {
    // مجموع نقاط كل طفل ضمن الفترة
    final totals = _children.map((c) {
      final id = c['id'] as int;
      final pts = _tasksFor(childId: id)
          .where((t) => t['isCompleted'] == true)
          .fold<int>(0, (sum, t) => sum + (t['points'] as int));
      return {
        'id': id,
        'name': c['name'],
        'color': c['color'],
        'value': pts,
      };
    }).toList()
      ..sort((a, b) => (b['value'] as int).compareTo(a['value'] as int));

    final maxVal = (totals.isEmpty)
        ? 1
        : totals.map((e) => e['value'] as int).reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('مقارنة النقاط بين الأطفال', Icons.trending_up, Colors.blue),
          const SizedBox(height: 16),
          ...totals.map((item) {
            final val = item['value'] as int;
            final perc = maxVal == 0 ? 0.0 : val / maxVal;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item['name']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Text(
                        '$val نقطة',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (item['color'] as Color),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Stack(
                    children: [
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                          width: perc * MediaQuery.of(context).size.width * 0.78,
                          height: 10,
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // توزيع أنواع المهام (للطفل المحدد)
  Widget _buildTaskTypesDistribution(Map<String, dynamic> m) {
    final typeCounts = (m['typeCounts'] as Map<String, int>);
    final total = typeCounts.values.fold<int>(0, (s, v) => s + v);
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
                final color = _typeColor(e.key);
                final icon = _typeIcon(e.key);
                return _legendChip(label: e.key, percent: perc, color: color, icon: icon);
              }).toList(),
            ),
        ],
      ),
    );
  }

  // الإنجازات الأخيرة
  Widget _buildRecentAchievements(List<Map<String, dynamic>> recent) {
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
              child: Text('لا توجد إنجازات حديثة.',
                  style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
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
    final when = _relativeTime(completedAt);
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

  // زر التصدير
  Widget _buildExportButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _exportReport,
        icon: const Icon(Icons.file_download_outlined, size: 18),
        label: const Text(
          'تصدير التقرير كـ PDF',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
    );
  }

  // ----- عناصر مساعدة للواجهة -----
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

  Widget _legendChip({required String label, required int percent, required Color color, required IconData icon}) {
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

  IconData _typeIcon(String type) {
    switch (type) {
      case 'دراسية':
        return Icons.school_rounded;
      case 'منزلية':
        return Icons.home_rounded;
      case 'تطوير':
        return Icons.psychology_rounded;
      case 'رياضية':
        return Icons.sports_soccer_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'دراسية':
        return Colors.blue;
      case 'منزلية':
        return Colors.orange;
      case 'تطوير':
        return Colors.green;
      case 'رياضية':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDuration(Duration? d) {
    if (d == null) return '-';
    final h = d.inHours;
    final m = d.inMinutes % 60;
    if (h == 0) return '$m د';
    return '$h س $m د';
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return 'قبل ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'قبل ${diff.inHours} ساعة';
    if (diff.inDays < 7) return 'قبل ${diff.inDays} يوم';
    final weeks = (diff.inDays / 7).floor();
    return 'قبل $weeks أسبوع';
  }

  void _exportReport() {
    // TODO: تنفيذ تصدير PDF
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _selectedChildId == null
              ? 'سيتم تصدير تقرير العائلة كـ PDF'
              : 'سيتم تصدير تقرير ${_children.firstWhere((c) => c["id"] == _selectedChildId)["name"]} كـ PDF',
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
