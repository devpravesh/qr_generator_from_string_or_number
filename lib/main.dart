import 'package:flutter/material.dart';
import 'package:qr_generator/qr_generator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NumberToQR());
  }
}
