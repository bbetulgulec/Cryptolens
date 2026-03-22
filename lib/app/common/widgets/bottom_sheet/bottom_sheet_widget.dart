import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_card_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_title_row_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/crypto_chart_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/segmented_time_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/upper_limit_text.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:crypto_lens/app/common/constants/app_color.dart'; // Renklerin olduğu yer

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.midnightBlue,
      isScrollControlled: true,
      builder: (_) => const BottomSheetWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> mockChartData = [
      const FlSpot(0, 3),
      const FlSpot(2, 4),
      const FlSpot(4, 3.5),
      const FlSpot(6, 5),
      const FlSpot(8, 2),
      const FlSpot(10, 4.5),
    ];
    return SizedBox(
      height: context.height * 0.8, // Sabit %80 yükseklik
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetTitleRowWidget(),
          const Divider(color: Colors.white10),
          AppText.big("\$ 65,4655.23", color: AppColor.white),
          UpperLimitText(),
          CryptoChartWidget(spots: mockChartData),
          SegmentedTimeWidget(),
          Expanded(child: BottomSheetCardWidget()),
        ],
      ),
    );
  }
}
