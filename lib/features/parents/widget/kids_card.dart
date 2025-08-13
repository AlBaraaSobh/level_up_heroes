import 'package:flutter/material.dart';
import 'package:level_up_heroes/core/constants/app_colors.dart';

class KidsCard extends StatelessWidget {
  final Map<String, dynamic> child;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const KidsCard({
    super.key,
    required this.child,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });


  @override
  Widget build(BuildContext context) {
    final profileColor = child['profileColor'] as Color;
    final progressPercent = child['progressPercent'] as double;
    final firstLetter = child['name'].toString()[0];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: profileColor.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: profileColor.withOpacity(0.18),
              blurRadius: 30,
              offset: const Offset(0, 12),
              spreadRadius: -12,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        profileColor.withOpacity(0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: 'child_avatar_$index',
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  profileColor,
                                  profileColor.withOpacity(0.7),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: profileColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                firstLetter,
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                child['name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3748),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: profileColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'المستوى ${child['level']}',
                                      style: TextStyle(
                                        color: profileColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '⭐ ${child['points']} نقطة',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF718096),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, size: 22, color: Color(0xFF718096)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onSelected: (value) {
                            if (value == 'edit') onEdit();
                            if (value == 'delete') onDelete();
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: const [
                                  Icon(Icons.edit, size: 18, color: Colors.black54),
                                  SizedBox(width: 8),
                                  Text('تعديل'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: const [
                                  Icon(Icons.delete, size: 18, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('حذف', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progressPercent,
                        minHeight: 8,
                        backgroundColor: const Color(0xFFF1F5F9),
                        valueColor: AlwaysStoppedAnimation<Color>(profileColor),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            "المهام",
                            child['tasksCompleted'],
                            Icons.check_circle,
                            Colors.green,
                          ),
                        ),

                        // 🔹 خط فاصل بين البادجتين
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey.withOpacity(0.3),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),

                        Expanded(
                          child: _buildStatCard(
                            "الإنجازات",
                            child['achievements'],
                            Icons.emoji_events,
                            Colors.amber,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // زر التفاصيل الموسع
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: عرض التفاصيل
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: profileColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "📋",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildStatCard(String label, int value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color.withOpacity(0.9),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

}
