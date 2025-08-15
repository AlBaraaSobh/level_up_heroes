import 'package:flutter/material.dart';

class ExportButton extends StatelessWidget {
  final VoidCallback onExport;

  const ExportButton({super.key, required this.onExport});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onExport,
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
}
