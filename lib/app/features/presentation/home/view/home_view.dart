import 'package:crypto_lens/app/features/presentation/home/widget/assets_card_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/search_bar_row_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/text_row_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchBarRowWidget(),
          TextRowWidget(),
          AssetsCardWidget(),
          AssetsCardWidget(),
          AssetsCardWidget(),
        ],
      ),
    );
  }
}
