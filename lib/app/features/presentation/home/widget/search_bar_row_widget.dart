import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/filter_bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarRowWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBarRowWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. ADIM: SearchBar'ı Expanded ile sarıyoruz
        Expanded(
          child: SearchBar(
            hintText: "Search Assets",
            hintStyle: const WidgetStatePropertyAll(
              TextStyle(color: Colors.white54),
            ),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(color: Colors.white),
            ), // Yazı rengi
            backgroundColor: const WidgetStatePropertyAll(AppColor.cloudyBlue),
            leading: const Icon(Icons.search, color: Colors.white54),
            elevation: const WidgetStatePropertyAll(0), // Gölgeyi kaldırdık
            onChanged: (value) {
              onChanged(
                value,
              );
            },
          ),
        ),
        const SizedBox(width: 12), // Aradaki boşluk
        // 2. ADIM: Filtre Butonu
        GestureDetector(
          // SearchBarRowWidget içinde onTap kısmı
          onTap: () {
            final homeBloc = context.read<HomeBloc>(); // Bloc'un kendisini al
            final state = homeBloc.state; // State'i al

            FilterBottomSheetWidget.show(
              context,
              homeBloc, // Bloc'u gönder
              state.orderBy,
              state.orderDirection,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.cloudyBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
