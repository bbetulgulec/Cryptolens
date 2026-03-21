import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:flutter/material.dart';

final class AppThemeData {
  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColor.richBlack,
    navigationBarTheme: _navigationBarTheme,
    appBarTheme: _appBarTheme,
  );

  static final NavigationBarThemeData _navigationBarTheme =
      NavigationBarThemeData(
        backgroundColor: AppColor.midnightBlue,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColor.neonBlue.withAlpha(20),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColor.neonBlue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            );
          }
          return const TextStyle(color: Colors.white70, fontSize: 12);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColor.neonBlue);
          }
          return const IconThemeData(color: Colors.white);
        }),
      );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppColor.skyBlue,
    centerTitle: false,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColor.skyBlue,
    ),
    scrolledUnderElevation: 0,
  );
}
