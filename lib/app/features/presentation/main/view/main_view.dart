import 'package:crypto_lens/app/features/presentation/home/view/home_view.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_bloc.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_state.dart';
import 'package:crypto_lens/app/features/presentation/main/widget/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeView(), // 0. index: Burası açılacak
      const Center(
        child: Text("Analysis", style: TextStyle(color: Colors.white)),
      ),
      const Center(
        child: Text("Trade", style: TextStyle(color: Colors.white)),
      ),
      const Center(
        child: Text("Settings", style: TextStyle(color: Colors.white)),
      ),
    ];
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Scaffold(
            // BLoC'tan gelen selectedIndex'e göre sayfayı listeden seçiyoruz
            body: pages[state.selectedIndex],
            bottomNavigationBar: const BottomBarWidget(),
          );
        },
      ),
    );
  }
}
