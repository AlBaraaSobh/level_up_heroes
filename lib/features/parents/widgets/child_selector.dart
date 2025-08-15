import 'package:flutter/material.dart';

class ChildSelector extends StatelessWidget {
  final List<Map<String, dynamic>> children;
  final int? selectedChildId;
  final ValueChanged<int?> onChildSelected;

  const ChildSelector({
    super.key,
    required this.children,
    required this.selectedChildId,
    required this.onChildSelected,
  });

  @override
  Widget build(BuildContext context) {
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
              selected: selectedChildId == null,
              onTap: () => onChildSelected(null),
            ),
            const SizedBox(width: 8),
            ...children.map((c) {
              final id = c['id'] as int;
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: _childChip(
                  label: c['name'] as String,
                  emoji: c['avatar'] as String,
                  color: c['color'] as Color,
                  selected: selectedChildId == id,
                  onTap: () => onChildSelected(id),
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
}
