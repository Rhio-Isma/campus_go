
import 'package:flutter/material.dart';

import 'pages/detail_data.dart' as data;
import 'pages/detail_absensi.dart' as absensi;
import 'widgets/student_info_card.dart';
import 'widgets/absensi_info_card.dart';
import 'widgets/custom_button.dart';

void main() {
  runApp(const CampusGoApp());
}

class Student {
  final int id;
  final String nim;
  final String name;
  final String major;
  final int semester;
  final String email;
  final int attendance;
  const Student({
    required this.id,
    required this.nim,
    required this.name,
    required this.major,
    required this.semester,
    required this.email,
    required this.attendance,
  });
}

class CampusGoApp extends StatelessWidget {
  const CampusGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusGo',
      home: CampusGoHomePage(),
    );
  }
}

class CampusGoHomePage extends StatefulWidget {
  const CampusGoHomePage({super.key});

  @override
  State<CampusGoHomePage> createState() =>
      _CampusGoHomePageState();
}

class _CampusGoHomePageState extends State<CampusGoHomePage> {
  int _counter = 0;

  // Contoh data mahasiswa
  final String _nama = 'Rhio Isma Rizky Aziz';
  final String _nim = '411231085';

  // Halaman absensi dengan jam dan timer kerja
  void _navigateToAbsensi() {
    // Waktu dicatat saat tombol Absen Masuk ditekan
    final DateTime waktuAbsen = DateTime.now();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => absensi.DetailAbsensi(
          nama: _nama,
          nim: _nim,
          waktuMasuk: waktuAbsen,
        ),
      ),
    );
  }

  // Halaman detail presensi biasa
  void _navigateToDetailData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => data.DetailData(
          nama: _nama,
          nim: _nim,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusGo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 80),
              const SizedBox(height: 16),

              const Text(
                'CampusGo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                'Mobile Academic Information System',
              ),
              const SizedBox(height: 8),

              Text(
                'Total Aktivitas: $_counter',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 24),

              CampusButton(
                label: 'Absen Masuk',
                icon: Icons.login,
                type: CampusButtonType.primary,
                onPressed: _navigateToAbsensi,
              ),

              const SizedBox(height: 12),

              CampusButton(
                label: 'Lihat Detail Presensi',
                icon: Icons.assignment_ind,
                type: CampusButtonType.secondary,
                onPressed: _navigateToDetailData,
              ),

              const SizedBox(height: 12),

              CampusButton(
                label: 'Butuh Bantuan?',
                icon: Icons.help_outline,
                type: CampusButtonType.tertiary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Membuka Pusat Bantuan...',
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),
              const StudentInfoCard(),
              const SizedBox(height: 12),
              const AbsensiInfoCard(),
            ],
          ),
        ),
      ),
    );
  }
}
