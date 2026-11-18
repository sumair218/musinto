import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const pink = Color(0xFFFF2D6F);
  static const dark = Color(0xFF2B2B2D);
  static const grey = Color(0xFFF1F1F1);
  static const hint = Color(0xFF9A9A9A);
}

ThemeData buildTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.pink),
      textTheme: GoogleFonts.lexendTextTheme(),
    );
