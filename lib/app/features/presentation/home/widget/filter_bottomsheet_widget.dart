import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/build_option_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/filter_button_widget.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_event.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final String initialOrderBy;
  final String initialDirection;

  const FilterBottomSheetWidget({
    super.key,
    required this.initialOrderBy,
    required this.initialDirection,
  });

  static Future<void> show(
    BuildContext context,
    HomeBloc homeBloc,
    String orderBy,
    String direction,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.midnightBlue,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => BlocProvider.value(
        value: homeBloc,
        child: FilterBottomSheetWidget(
          initialOrderBy: orderBy,
          initialDirection: direction,
        ),
      ),
    );
  }

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late String localOrderBy;
  late String localDirection;

  @override
  void initState() {
    super.initState();
    localOrderBy = widget.initialOrderBy;
    localDirection = widget.initialDirection;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextWidget.semiBold("Sort Options", color: AppColor.cloudyBlue),
        const Divider(color: AppColor.skyBlue, height: 30),

        // Yön Seçimi
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDirectionChip("Descending", "desc", Icons.trending_down),
            _buildDirectionChip("Ascending", "asc", Icons.trending_up),
          ],
        ),
        const SizedBox(height: 20),

        BuildOptionWidget(
          title: "Market Cap",
          isSelected: localOrderBy == "marketCap",
          icon: Icons.pie_chart,
          onTap: () => setState(() => localOrderBy = "marketCap"),
        ),
        BuildOptionWidget(
          title: "Price",
          isSelected: localOrderBy == "price",
          icon: Icons.attach_money,
          onTap: () => setState(() => localOrderBy = "price"),
        ),
        BuildOptionWidget(
          title: "24h Volume",
          isSelected: localOrderBy == "24hVolume",
          icon: Icons.pie_chart,
          onTap: () => setState(() => localOrderBy = "24hVolume"),
        ),
        BuildOptionWidget(
          title: "Change (%)",
          isSelected: localOrderBy == "change",
          icon: Icons.attach_money,
          onTap: () => setState(() => localOrderBy = "change"),
        ),
        BuildOptionWidget(
          title: "Listing Date",
          isSelected: localOrderBy == "listedAt",
          icon: Icons.attach_money,
          onTap: () => setState(() => localOrderBy = "listedAt"),
        ),

        FilterButtonWidget(
          localOrderBy: localOrderBy,
          localDirection: localDirection,
          onPressed: () {
            context.read<HomeBloc>().add(
              Filtered(orderBy: localOrderBy, orderDirection: localDirection),
            );
            Navigator.pop(context);
          },
        ),
      ],
    ).symmetricPadding(
      horizontal: context.width * 0.05,
      vertical: context.height * 0.03,
    );
  }

  Widget _buildDirectionChip(String label, String value, IconData icon) {
    final bool isSelected = localDirection == value;
    return GestureDetector(
      onTap: () => setState(
        () => localDirection = value,
      ), // Sadece içerideki durumu değiştirir
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.015,
          vertical: context.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.neonBlue.withAlpha(30)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColor.neonBlue : Colors.white10,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColor.neonBlue : Colors.white60,
              size: 18,
            ),
            SizedBox(width: context.width * 0.01),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColor.neonBlue : Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
