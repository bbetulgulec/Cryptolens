import 'package:crypto_lens/app/common/constants/app_strings.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_bloc.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_event.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return NavigationBar(
            selectedIndex: state.selectedIndex,
            onDestinationSelected: (index) {
              context.read<MainBloc>().add(MainTabChanged(index));
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet),
                label: AppStrings.home,
              ),
              NavigationDestination(icon: Icon(Icons.star), label: AppStrings.favorites),
            ],
          );
        },
      ),
    );
  }
}
