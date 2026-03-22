import 'package:crypto_lens/app/common/constants/app_theme_data.dart';
import 'package:crypto_lens/app/features/presentation/login/view/login_view.dart';
import 'package:crypto_lens/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Navigation.navigationKey,
      theme: AppThemeData.themeData,
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
    );
  }
}
