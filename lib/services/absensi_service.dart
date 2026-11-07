import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/absensi_info.dart';

//TINJAUAN PUSTAKA
class AbsensiService {
static Future<AbsensiInfo> fetchAbsensiInfo() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  // Mengirim HTTP GET Request ke server
  final response = await http.get(uri);

  // Memeriksa HTTP Status Code (200 = Success)
  if (response.statusCode == 200) {
    final List<dynamic> listJson = jsonDecode(response.body) as List<dynamic>;

    // Ambil item pertama dari list postingan sebagai contoh data
    final Map<String, dynamic> firstItem = listJson.first as Map<String, dynamic>;

    return AbsensiInfo.fromJson(firstItem);
  } else {
    throw Exception('Gagal memuat data dari server (Status Code: ${response.statusCode})');
  }
}
}