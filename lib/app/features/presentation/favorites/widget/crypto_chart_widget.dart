import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CryptoChartWidget extends StatelessWidget {
  final List<FlSpot> spots;
  const CryptoChartWidget({super.key, required this.spots});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 3,
              color: AppColor.neonBlue,
              dotData: const FlDotData(show: false), // Noktaları gizle
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppColor.neonBlue.withAlpha(90),
                    AppColor.neonBlue.withAlpha(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    ).symmetricPadding(horizontal: context.height * 0.01);
  }
}
