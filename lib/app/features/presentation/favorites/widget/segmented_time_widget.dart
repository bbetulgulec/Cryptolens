import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';

class SegmentedTimeWidget extends StatelessWidget {
  final String
  selectedPeriod; // BLoC'tan veya üst widget'tan gelecek (Örn: "7D")

  const SegmentedTimeWidget({
    super.key,
    this.selectedPeriod = "7D", // Varsayılan olarak 7D seçili başlasın
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(context, "1D"),
          _buildButton(context, "7D"),
          _buildButton(context, "1M"),
          _buildButton(context, "1Y"),
          _buildButton(context, "ALL"),
        ],
      ),
    ).allPadding(context.height * 0.02);
  }

  Widget _buildButton(BuildContext context, String title) {
    // Eğer butonun ismi seçili olanla aynıysa "aktif" stilini uygula
    final bool isSelected = selectedPeriod == title;

    return GestureDetector(
      onTap: () {
        // Tıklama anında BLoC'a haber vereceğiz
        // context.read<ChartBloc>().add(ChangePeriodEvent(title));
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.neonBlue.withAlpha(60)
              : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColor.electricBlue : AppColor.skyBlue,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ).allPadding(context.height * 0.02),
      ),
    );
  }
}
