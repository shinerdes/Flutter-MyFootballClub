import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

// themes entries
final Map<ThemesModes, AppColorTheme> themes = {
  //light theme
  ThemesModes.light: AppColorTheme(
      primaryColor: const Color(0xFF561BCC),
      primaryBackgroudColor: const Color(0XFFDFECF1),
      primaryIconColor: const Color.fromARGB(255, 6, 7, 71),
      primaryPanelsColor: const Color(0xFFD0E1E9),
      sidebar: SideBarTheme(
          appTitle: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 24),
          selectedIconsColor: const Color(0xFF561BCC),
          selectedTitlesColor: const Color(0xFF561BCC),
          backgroudColor: const Color.fromARGB(255, 0, 0, 0),
          iconsColor: const Color.fromARGB(255, 255, 255, 255),
          titlesColor: const Color.fromARGB(255, 255, 255, 255)),
      styles: AppTextStyleTheme(
        title: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 30, 30, 30),
            fontSize: 40,
            fontWeight: FontWeight.bold),
        title2: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 56, 56, 56),
            fontSize: 35,
            fontWeight: FontWeight.bold),
        title3: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 13, 13, 13),
            fontSize: 24,
            fontWeight: FontWeight.bold),
        subTitle: GoogleFonts.poppins(
          color: const Color.fromARGB(255, 13, 13, 13),
          fontSize: 18,
        ),
        subTitle2: GoogleFonts.poppins(
          color: const Color.fromARGB(255, 13, 13, 13),
          fontSize: 15,
        ),
        subTitle3: GoogleFonts.poppins(
          color: const Color.fromARGB(255, 13, 13, 13),
          fontSize: 12,
        ),
      )),

  //dark theme
  ThemesModes.dark: AppColorTheme(
      primaryColor: const Color.fromARGB(255, 231, 217, 251),
      primaryBackgroudColor: const Color.fromARGB(255, 18, 18, 18),
      primaryIconColor: const Color.fromARGB(255, 236, 236, 236),
      primaryPanelsColor: const Color.fromARGB(255, 41, 41, 41),
      sidebar: SideBarTheme(
          appTitle: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 24),
          selectedIconsColor: const Color(0xFF561BCC),
          selectedTitlesColor: const Color.fromARGB(255, 18, 0, 43),
          backgroudColor: const Color.fromARGB(255, 255, 255, 255),
          iconsColor: const Color.fromARGB(255, 35, 35, 35),
          titlesColor: const Color.fromARGB(255, 23, 23, 23)),
      styles: AppTextStyleTheme(
        title: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 40,
            fontWeight: FontWeight.bold),
        title2: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 35,
            fontWeight: FontWeight.bold),
        title3: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 24,
            fontWeight: FontWeight.bold),
        subTitle: GoogleFonts.poppins(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontSize: 18,
        ),
        subTitle2: GoogleFonts.poppins(
          color: const Color.fromARGB(255, 13, 13, 13),
          fontSize: 15,
        ),
        subTitle3: GoogleFonts.poppins(
          color: const Color.fromARGB(255, 13, 13, 13),
          fontSize: 12,
        ),
      )),
};
