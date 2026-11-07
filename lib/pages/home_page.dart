import 'package:flutter/material.dart';

import '../pages/detail_data.dart' as data;
import '../widgets/student_info_card.dart';
import '../widgets/absensi_info_card.dart';
import '../widgets/custom_button.dart';
import '../models/student.dart';
import '../models/absensi_info.dart';
import '../services/student_service.dart';
import '../services/absensi_service.dart';

class CampusGoHomePage extends StatefulWidget {
  const CampusGoHomePage({super.key});

  @override
  State<CampusGoHomePage> createState() => _CampusGoHomePageState();
}

class _CampusGoHomePageState extends State<CampusGoHomePage> {
  // Shared state values
  final String _nim = '411231085';
  final String _name = 'Rhio Isma Rizky Aziz';

  int _counter = 0;
  late Future<List<Student>> studentsFuture;
  late Future<AbsensiInfo> absensiFuture;

  @override
  void initState() {
    super.initState();
    studentsFuture = StudentService.loadStudents();
    absensiFuture = AbsensiService.fetchAbsensiInfo();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Reload data dari Network API
  void reloadAbsensi() {
    setState(() {
      absensiFuture = AbsensiService.fetchAbsensiInfo();
    });
  }

  // Memuat ulang data JSON
  void reloadStudents() {
    setState(() {
      studentsFuture = StudentService.loadStudents();
    });
  }

  // Halaman detail presensi biasa
  void _navigateToDetailData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => data.DetailData(
          nama: _name,
          nim: _nim,
        ),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CampusGo')),
      body: FutureBuilder<List<Student>>(
        future: studentsFuture,
        builder: (context, snapshot) {
          // 1. LOADING STATE
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. ERROR STATE
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 56,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Gagal membaca data mahasiswa.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CampusButton(
                      label: 'Coba Lagi',
                      onPressed: reloadStudents,
                    ),
                  ],
                ),
              ),
            );
          }
          // 3. MENGAMBIL DATA
          final students = snapshot.data ?? <Student>[];
          // 4. EMPTY STATE
          if (students.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline, size: 56),
                  SizedBox(height: 12),
                  Text('Data mahasiswa kosong'),
                ],
              ),
            );
          }
          return Column(
            children: [
              const Icon(Icons.school, size: 80),
              const SizedBox(height: 16),
              const Text(
                'CampusGo',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Mobile Academic Information System'),
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
                label: 'Tambah Aktivitas',
                icon: Icons.play_arrow,
                type: CampusButtonType.primary,
                onPressed: () {
                  _incrementCounter();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aktivitas Berhasil Dimulai!'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              CampusButton(
                label: 'Lihat Jadwal',
                icon: Icons.calendar_today,
                type: CampusButtonType.secondary,
                onPressed: () {
                  _navigateToDetailData();
                },
              ),
              const SizedBox(height: 12),
              CampusButton(
                label: 'Butuh Bantuan?',
                icon: Icons.help_outline,
                type: CampusButtonType.tertiary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Membuka Pusat Bantuan...')),
                  );
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return StudentInfoCard(
                      nim: student.nim,
                      name: student.name,
                      major: student.major,
                      semester: student.semester,
                      email: student.email,
                      attendance: student.attendance,
                       );
                  },
                ),
              ),
              const SizedBox(height: 12),
              FutureBuilder<AbsensiInfo>(
                future: absensiFuture,
                builder: (context, snapshot) {
                  // State Loading API
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }


                  // State Error API
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Text(
                            'Gagal memuat API Absensi: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          CampusButton(
                            label: 'Coba Lagi Absensi',
                            onPressed: reloadAbsensi,
                          ),
                        ],
                      ),
                    );
                  }


                  // State Success API
                  if (snapshot.hasData) {
                    return AbsensiInfoCard(info: snapshot.data!);
                  }


                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}