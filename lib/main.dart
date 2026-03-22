import 'package:crypto_lens/app/common/constants/app_theme_data.dart';
import 'package:crypto_lens/app/common/functions/app_functions.dart';
import 'package:crypto_lens/app/common/get_it/get_it.dart';
import 'package:crypto_lens/app/features/presentation/login/view/login_view.dart';
import 'package:crypto_lens/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppFunctions.instance.init();

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
