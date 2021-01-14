import 'package:flutter/material.dart';

const Color primary = Colors.green;

const Color accent = primary;

ThemeData get lightTheme => ThemeData(
      primaryColor: accent,
      accentColor: accent,
      buttonTheme: ButtonThemeData(
        buttonColor: accent,
        textTheme: ButtonTextTheme.primary,
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        backgroundColor: accent,
      ),
    );

ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      primaryColor: accent,
      accentColor: accent,
      buttonTheme: ButtonThemeData(
        buttonColor: accent,
        textTheme: ButtonTextTheme.primary,
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.grey[850],
      ),
    );
