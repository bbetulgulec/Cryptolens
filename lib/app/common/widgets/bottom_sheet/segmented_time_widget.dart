import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';
class SegmentedTimeWidget extends StatelessWidget {
  final String selectedPeriod;
  final String uuid;
  final Function(String)? onChanged; // 🔥 EKLENDİ

  const SegmentedTimeWidget({
    super.key,
    required this.selectedPeriod,
    required this.uuid,
    this.onChanged, // 🔥 EKLENDİ
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> periods = {
      "12H": "12h",
      "24H": "24h",
      "7D": "7d",
      "30D": "30d",
      "1Y": "1y",
      "5Y": "5y",
    };

    return Container(
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: periods.entries.map((entry) {
          return _buildButton(context, entry.key, entry.value);
        }).toList(),
      ),
    ).allPadding(context.height * 0.02);
  }

  Widget _buildButton(BuildContext context, String title, String apiValue) {
    final bool isSelected = selectedPeriod == apiValue;

    return GestureDetector(
      onTap: () {
        onChanged?.call(apiValue); // 🔥 ARTIK BURASI
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.neonBlue.withAlpha(60)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColor.electricBlue : AppColor.skyBlue,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ).allPadding(context.height * 0.01),
      ),
    );
  }
}