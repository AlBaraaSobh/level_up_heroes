import 'package:flutter/material.dart';

class FamilyPointsComparison extends StatefulWidget {
  final List<Map<String, dynamic>> totals;

  const FamilyPointsComparison({
    super.key,
    required this.totals,
  });

  @override
  State<FamilyPointsComparison> createState() => _FamilyPointsComparisonState();
}

class _FamilyPointsComparisonState extends State<FamilyPointsComparison>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.totals.isEmpty) {
      return _buildEmptyState();
    }

    final maxValue = _getMaxValue();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildChart(maxValue),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Icon(
          Icons.bar_chart,
          color: Colors.blue,
          size: 20,
        ),
        SizedBox(width: 8),
        Text(
          'مقارنة نقاط العائلة',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2E3A59),
          ),
        ),
      ],
    );
  }

  Widget _buildChart(double maxValue) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: widget.totals
              .map((child) => _buildBar(child, maxValue))
              .toList(),
        );
      },
    );
  }

  Widget _buildBar(Map<String, dynamic> child, double maxValue) {
    final value = _getValue(child);
    final progress = maxValue == 0 ? 0.0 : value / maxValue;
    final barHeight = 80.0 * progress * _animation.value;
    final color = _getColor(child);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // القيمة
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(
                value.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            // العمود
            Container(
              width: 24,
              height: barHeight,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            // الاسم
            Text(
              _getName(child),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: _cardDecoration(),
      child: const Column(
        children: [
          Icon(
            Icons.bar_chart_outlined,
            size: 48,
            color: Color(0xFFCBD5E1),
          ),
          SizedBox(height: 12),
          Text(
            'لا توجد بيانات للعرض',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  double _getMaxValue() {
    if (widget.totals.isEmpty) return 1.0;
    return widget.totals
        .map(_getValue)
        .reduce((a, b) => a > b ? a : b);
  }

  double _getValue(Map<String, dynamic> child) {
    return (child['value'] as num?)?.toDouble() ?? 0.0;
  }

  String _getName(Map<String, dynamic> child) {
    return child['name']?.toString() ?? '';
  }

  Color _getColor(Map<String, dynamic> child) {
    return (child['color'] as Color?) ?? Colors.blue;
  }
}