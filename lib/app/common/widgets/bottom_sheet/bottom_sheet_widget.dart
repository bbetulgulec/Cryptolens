import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_card_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_title_row_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/crypto_chart_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/segmented_time_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/upper_limit_text_widget.dart';
import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:crypto_lens/app/common/constants/app_color.dart';

class BottomSheetWidget extends StatelessWidget {
  final CoinsModel coin;
  final bool isLoading;
  final String selectedTime;
  final Function(String newTime)? onTimeChanged;

  const BottomSheetWidget({
    super.key,
    required this.coin,
    this.isLoading = false,
    this.selectedTime = "7d",
    this.onTimeChanged,
  });

  // static show metodunu Bloc'tan arındırdık, sadece parametre alıyor
  static Future<void> show(BuildContext context, {required Widget child}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.midnightBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      isScrollControlled: true,
      builder: (_) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Grafik verisini hazırla
    final List<FlSpot> chartData = coin.sparkline
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), double.tryParse(e.value) ?? 0))
        .toList();

    return SizedBox(
      height: context.height * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetTitleRowWidget(
            iconPath: coin.iconUrl,
            name: coin.name,
            symbol: coin.symbol,
          ),
          const Divider(color: Colors.white10),

          // Loading göstergesi
          if (isLoading)
            const LinearProgressIndicator(
              color: AppColor.neonBlue,
              backgroundColor: Colors.transparent,
            ),

          AppTextWidget.big(
            "\$${double.tryParse(coin.price)?.toStringAsFixed(2) ?? coin.price}",
            color: AppColor.white,
          ),
          UpperLimitTextWidget(price: coin.change),

          CryptoChartWidget(spots: chartData),

          SegmentedTimeWidget(
            uuid: coin.uuid,
            selectedPeriod: selectedTime,
            onChanged: onTimeChanged, 
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BottomSheetCardWidget(coin: coin),
            ),
          ),
        ],
      ),
    );
  }
}
