import 'package:crypto_lens/app/features/presentation/main/widget/bottom_bar_widget.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: BottomBarWidget());
  }
}
