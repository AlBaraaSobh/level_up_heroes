import 'package:flutter/material.dart';

import '../widgets/behavior_insights.dart';
import '../widgets/child_selector.dart';
import '../widgets/export_button.dart';
import '../widgets/family_points_comparison.dart';
import '../widgets/parents_app_bar.dart';
import '../widgets/period_filter.dart';
import '../widgets/recent_achievements.dart';
import '../widgets/stats_grid.dart';
import '../widgets/task_types_distribution.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _children = [
    {'id': 1, 'name': 'أحمد', 'avatar': '👦', 'color': Colors.blue},
    {'id': 2, 'name': 'ليان', 'avatar': '👧', 'color': Colors.pink},
    {'id': 3, 'name': 'محمد', 'avatar': '🧒', 'color': Colors.green},
  ];

  final List<Map<String, dynamic>> _tasks = [];

  int? _selectedChildId;
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
          (t['completedAt'] != null && (t['completedAt'] as DateTime).isAfter(_periodStart));
      final forChild = childId == null ? true : (t['assignedChildren'] as List).contains(childId);
      return inPeriod && forChild;
    }).toList();
  }

  Map<String, dynamic> _computeMetrics() {
    final tasks = _tasksFor(childId: _selectedChildId);
    final total = tasks.length;
    final completed = tasks.where((t) => t['completedAt'] != null).length;
    final pending = total - completed;

    // typeCounts افتراضية لتجنب Null
    final Map<String, int> typeCounts = {};
    for (var t in tasks) {
      final type = t['type'] ?? 'عام';
      typeCounts[type] = (typeCounts[type] ?? 0) + 1;
    }

    return {
      'totalTasks': total,
      'completed': completed,
      'pending': pending,
      'typeCounts': typeCounts,
      'completionRate': total == 0 ? 0.0 : (completed / total) * 100.0,
      'bestTime': 'مساء',
      'avgDuration': const Duration(minutes: 30),
    };
  }

  List<Map<String, dynamic>> _recentAchievements() {
    final tasks = _tasksFor(childId: _selectedChildId);
    return tasks.map((t) {
      return {
        'title': t['title'] ?? 'مهمة',
        'points': t['points']?.toDouble() ?? 10.0,
        'completedAt': t['completedAt'] ?? DateTime.now(),
        'color': Colors.orange,
      };
    }).toList();
  }

  void _exportReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_selectedChildId == null
            ? 'سيتم تصدير تقرير العائلة كـ PDF'
            : 'سيتم تصدير تقرير ${_children.firstWhere((c) => c['id'] == _selectedChildId)["name"]} كـ PDF'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _computeMetrics();
    final bg = const Color(0xFFF8FAFF);

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
              ChildSelector(
                children: _children,
                selectedChildId: _selectedChildId,
                onChildSelected: (id) {
                  setState(() => _selectedChildId = id);
                  _anim..reset()..forward();
                },
              ),
              const SizedBox(height: 12),
              PeriodFilter(
                options: _periodOptions,
                selectedPeriod: _selectedPeriod,
                onPeriodSelected: (p) {
                  setState(() => _selectedPeriod = p);
                  _anim..reset()..forward();
                },
              ),
              const SizedBox(height: 20),
              StatsGrid(items: [
                {
                  'title': 'المهام الكلية',
                  'value': metrics['totalTasks'].toString(),
                  'icon': Icons.list_alt,
                  'color': Colors.blue
                },
                {
                  'title': 'المكتملة',
                  'value': metrics['completed'].toString(),
                  'icon': Icons.check,
                  'color': Colors.green
                },
                {
                  'title': 'المعلقة',
                  'value': metrics['pending'].toString(),
                  'icon': Icons.pending_actions,
                  'color': Colors.red
                },
              ]),
              const SizedBox(height: 20),
              BehaviorInsights(
                childName: _selectedChildId == null
                    ? 'العائلة'
                    : _children.firstWhere((c) => c['id'] == _selectedChildId)['name'],
                rank: null,
                typeCounts: metrics['typeCounts'] as Map<String, int>,
                bestTime: metrics['bestTime'] as String,
                completionRate: metrics['completionRate'] as double,
                avgDuration: metrics['avgDuration'] as Duration,
              ),
              const SizedBox(height: 20),
              _selectedChildId == null
                  ? FamilyPointsComparison(
                totals: [
                  for (var c in _children)
                    {
                      'name': c['name'],
                      'value': _tasksFor(childId: c['id']).length.toDouble(),
                      'color': c['color']
                    }
                ],
              )
                  : TaskTypesDistribution(
                typeCounts: metrics['typeCounts'] as Map<String, int>,
                total: metrics['totalTasks'] as int,
                typeColor: (type) => Colors.blue,
                typeIcon: (type) => Icons.task,
              ),
              const SizedBox(height: 20),
              RecentAchievements(
                recent: _recentAchievements(),
                relativeTime: (DateTime dt) {
                  final diff = DateTime.now().difference(dt);
                  if (diff.inDays > 0) return '${diff.inDays} يوم';
                  if (diff.inHours > 0) return '${diff.inHours} ساعة';
                  if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة';
                  return 'الآن';
                },
              ),
              const SizedBox(height: 20),
              ExportButton(onExport: _exportReport),
            ],
          );
        },
      ),
    );
  }
}
