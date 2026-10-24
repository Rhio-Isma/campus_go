// lib/widgets/campus_button.dart
import 'package:flutter/material.dart';

// Enum untuk menentukan tipe/hirarki tombol
enum CampusButtonType { primary, secondary, tertiary }

class CampusButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final CampusButtonType type;
  final IconData? icon;

  const CampusButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = CampusButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Isi konten tombol (Ikon + Teks)
    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );

    // Render jenis tombol berdasarkan tipe
    switch (type) {
      case CampusButtonType.primary:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: buttonContent,
        );

      case CampusButtonType.secondary:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: buttonContent,
        );

      case CampusButtonType.tertiary:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: buttonContent,
        );
    }
  }
}