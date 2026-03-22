import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:flutter/material.dart';

class BottomSheetCardWidget extends StatelessWidget {
  final CoinsModel coin;

  const BottomSheetCardWidget({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.8,
      children: [
        _buildInfoCard("RANK", "#${coin.rank}"),

        _buildInfoCard("MARKET CAP", _formatCurrency(coin.marketCap ?? '0')),

        _buildInfoCard("24H VOL", _formatCurrency(coin.volume24h)),

        _buildInfoCard(
          "ALL TIME HIGH",
          "\$${double.tryParse(coin.allTimeHigh.price ?? '0')?.toStringAsFixed(2) ?? '0.00'}",
        ),
      ],
    );
  }

  // Verileri formatlamak için  metod
  String _formatCurrency(String? value) {
    if (value == null || value == '0') return "N/A";

    // Önce varsa virgülleri temizleyelim
    final cleanValue = value.replaceAll(',', '');
    double val = double.tryParse(cleanValue) ?? 0;

    if (val == 0) return "\$0.00"; // Eğer gerçekten 0 ise

    if (val >= 1e12) return "\$${(val / 1e12).toStringAsFixed(2)}T";
    if (val >= 1e9) return "\$${(val / 1e9).toStringAsFixed(2)}B";
    if (val >= 1e6) return "\$${(val / 1e6).toStringAsFixed(2)}M";

    // Eğer rakam 1000'den büyükse binlik ayracı ekleyelim (Opsiyonel)
    return "\$${val.toStringAsFixed(0)}";
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.cloudyBlue.withAlpha(60)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.regular(title, color: AppColor.skyBlue),
          const SizedBox(height: 4),
          AppText.bold(value, color: AppColor.white),
        ],
      ),
    );
  }
}
