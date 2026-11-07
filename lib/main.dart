import 'package:flutter/material.dart';
import './pages/home_page.dart';

void main() {
  runApp(const CampusGoApp());
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