import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/constants/app_strings.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/filter_bottomsheet_widget.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarRowWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBarRowWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            hintText: AppStrings.searchAssets,
            hintStyle: const WidgetStatePropertyAll(
              TextStyle(color: AppColor.richBlack),
            ),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(color: AppColor.richBlack),
            ),
            backgroundColor: const WidgetStatePropertyAll(AppColor.skyBlue),
            leading: const Icon(
              Icons.search,
              color: AppColor.richBlack,
              size: 25,
            ),
            elevation: const WidgetStatePropertyAll(0),
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ),
        SizedBox(width: context.width * 0.03),
        GestureDetector(
          onTap: () {
            final homeBloc = context.read<HomeBloc>();
            final state = homeBloc.state;

            FilterBottomSheetWidget.show(
              context,
              homeBloc,
              state.orderBy,
              state.orderDirection,
            );
          },
          child: const Icon(Icons.tune, color: Colors.white),
        ),
      ],
    );
  }
}
