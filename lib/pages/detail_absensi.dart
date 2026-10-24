import 'dart:async';
import 'package:flutter/material.dart';

class DetailAbsensi extends StatefulWidget {
  final String nama;
  final String nim;
  final DateTime waktuMasuk;

  const DetailAbsensi({
    super.key,
    required this.nama,
    required this.nim,
    required this.waktuMasuk,
  });

  @override
  State<DetailAbsensi> createState() => _DetailAbsensiState();
}

class _DetailAbsensiState extends State<DetailAbsensi> {
  Timer? _timer;
  late DateTime waktuSekarang;

  @override
  void initState() {
    super.initState();

    waktuSekarang = DateTime.now();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        setState(() {
          waktuSekarang = DateTime.now();
        });
      },
    );
  }

  String formatJam(DateTime waktu) {
    final jam = waktu.hour.toString().padLeft(2, '0');
    final menit = waktu.minute.toString().padLeft(2, '0');
    final detik = waktu.second.toString().padLeft(2, '0');

    return '$jam:$menit:$detik';
  }

  String formatTanggal(DateTime waktu) {
    final hari = waktu.day.toString().padLeft(2, '0');
    final bulan = waktu.month.toString().padLeft(2, '0');

    return '$hari/$bulan/${waktu.year}';
  }

  String formatDurasi(Duration durasi) {
    if (durasi.isNegative) {
      durasi = Duration.zero;
    }

    final jam = durasi.inHours.toString().padLeft(2, '0');
    final menit = (durasi.inMinutes % 60)
        .toString()
        .padLeft(2, '0');
    final detik = (durasi.inSeconds % 60)
        .toString()
        .padLeft(2, '0');

    return '$jam:$menit:$detik';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final durasiKerja =
        waktuSekarang.difference(widget.waktuMasuk);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Absensi'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bukti Absensi Berhasil',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // JAM DIGITAL
            Card(
              color: Colors.blue.shade50,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.blue,
                      size: 45,
                    ),
                    const SizedBox(height: 8),
                    const Text('Jam Sekarang'),
                    const SizedBox(height: 8),
                    Text(
                      formatJam(waktuSekarang),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'Tanggal ${formatTanggal(waktuSekarang)}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // DATA KARYAWAN
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      title: const Text('Nama Karyawan'),
                      subtitle: Text(widget.nama),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.badge,
                        color: Colors.blue,
                      ),
                      title: const Text('ID Karyawan / NIM'),
                      subtitle: Text(widget.nim),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      title: Text('Status Absensi'),
                      subtitle: Text('Hadir - Tepat Waktu'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.login,
                        color: Colors.green,
                      ),
                      title: const Text('Jam Masuk'),
                      subtitle: Text(
                        '${formatJam(widget.waktuMasuk)}'
                        ' - ${formatTanggal(widget.waktuMasuk)}',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // DURASI KERJA
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.timer,
                      color: Colors.orange,
                      size: 42,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Durasi Sejak Absen Masuk',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      formatDurasi(durasiKerja),
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Jam : Menit : Detik',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
