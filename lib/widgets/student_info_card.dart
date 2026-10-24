import 'package:flutter/material.dart';

class StudentInfoCard extends StatelessWidget {
  final String nim;
  final String name;
  final String major;
  final int semester;
  final String email;
  final int attendance;

  const StudentInfoCard({
    super.key,
    required this.nim,
    required this.name,
    required this.major,
    required this.semester,
    required this.email,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // ====================================================
          // PROFILE ICON
          // ====================================================

          Container(
            width: 60,
            height: 60,

            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              shape: BoxShape.circle,
            ),

            child: Icon(Icons.person, size: 32, color: Colors.indigo.shade700),
          ),

          const SizedBox(width: 16),

          // ====================================================
          // DATA MAHASISWA
          // ====================================================
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 4),

                Text(
                  'NIM : $nim',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                SizedBox(height: 2),

                Text(
                  'Teknik Informatika',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}