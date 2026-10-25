import 'package:flutter/material.dart';

/// Palet warna & tema global aplikasi (hangat, bernuansa dapur Nusantara).
class AppColors {
  static const primary = Color(0xFFD1495B); // merah cabai
  static const dark = Color(0xFF3D2C2E);
  static const cream = Color(0xFFFFF4E0);
  static const accent = Color(0xFFF4A261);
}

ThemeData buildTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
    );
