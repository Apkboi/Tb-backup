import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triberly/core/constants/pallets.dart';

class AppTheme extends ChangeNotifier {
  ThemeData get selectedTheme => _selectedTheme;

  ThemeData _selectedTheme = lightTheme;
  TextTheme get selectedTextTheme => _selectedTheme.textTheme;

  void toggleTheme() {
    _selectedTheme = _selectedTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Pallets.primary,
    hintColor: Pallets.grey,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    sliderTheme: SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
    appBarTheme: AppBarTheme(
      color: Pallets.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
        size: 24,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      titleLarge:
          TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, height: 1.5),
      titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 14.0),
      bodySmall: TextStyle(fontSize: 12.0),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Pallets.primary,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    iconTheme: const IconThemeData(color: Pallets.primary),
    inputDecorationTheme: const InputDecorationTheme(
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.only(
        bottom: 16,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
    colorScheme: ColorScheme(
      background: Colors.white,
      brightness: Brightness.light,
      primary: Pallets.primary,
      secondary: Colors.blueAccent,
      error: Colors.red,
      onBackground: Colors.black,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      surface: Colors.grey[200]!,
    ),
  );

  static final ThemeData darkTheme = lightTheme.copyWith(
    brightness: Brightness.dark,
    primaryColor: Pallets.primary,
    hintColor: Colors.lightBlueAccent,
    scaffoldBackgroundColor: Colors.grey[850],
    appBarTheme: AppBarTheme(
      color: Pallets.white,
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    sliderTheme: SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
    textTheme: lightTheme.textTheme.apply(bodyColor: Colors.white70),
    iconTheme: const IconThemeData(color: Colors.white70),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blueGrey,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: lightTheme.inputDecorationTheme,
    colorScheme: lightTheme.colorScheme.copyWith(
      background: Colors.grey[900],
    ),
  );
}

final themeProvider = ChangeNotifierProvider<AppTheme>((ref) {
  return AppTheme();
});
