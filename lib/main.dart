import 'package:flutter/material.dart';
import 'screens/main_shell.dart';
import 'theme.dart';

void main() => runApp(const ResepNusantaraApp());

class ResepNusantaraApp extends StatelessWidget {
  const ResepNusantaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Nusantara',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const MainShell(),
    );
  }
}
