import 'package:flutter/material.dart';
import 'package:sda_hymnal/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDA Hymnal',
      home: HomeScreen(),
    );
  }
}
