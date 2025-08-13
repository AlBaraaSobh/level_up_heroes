import 'package:flutter/material.dart';

class TasksFilter extends StatelessWidget {
  final List<String> filterOptions;
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const TasksFilter({
    super.key,
    required this.filterOptions,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filterOptions.length,
        itemBuilder: (context, index) {
          final filter = filterOptions[index];
          final isSelected = selectedFilter == filter;
          return Container(
            margin: const EdgeInsets.only(left: 12),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) => onFilterChanged(filter),
              backgroundColor: Colors.white,
              selectedColor: Colors.blue.withOpacity(0.1),
              checkmarkColor: Colors.blue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.blue : const Color(0xFF64748B),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? Colors.blue : const Color(0xFFE2E8F0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
