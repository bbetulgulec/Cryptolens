import 'package:crypto_lens/app/common/constants/app_theme_data.dart';
import 'package:crypto_lens/app/features/presentation/main/view/main_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemeData.themeData,
      debugShowCheckedModeBanner: false,
      home: const MainView(),
    );
  }
}
