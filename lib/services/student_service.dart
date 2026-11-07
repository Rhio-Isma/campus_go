import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/student.dart';

class StudentService {
  //PENDAHULUAN
  static Future<List<Student>> loadStudents() async {
  // 1. Membaca file JSON sebagai String
  final jsonString = await rootBundle.loadString(
    'assets/data/students.json',
  );

  // 2. Mengubah String JSON menjadi struktur Dart
  final Map<String, dynamic> decoded =
      jsonDecode(jsonString) as Map<String, dynamic>;

  // 3. Mengambil array students dari JSON
  final List<dynamic> studentList =
      decoded['students'] as List<dynamic>;

  // 4. Mengubah setiap item menjadi objek Student
  return studentList.map((item) {
    return Student.fromJson(
      item as Map<String, dynamic>,
    );
  }).toList();
}
}