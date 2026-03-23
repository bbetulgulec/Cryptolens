import 'package:crypto_lens/app/common/widgets/bottom_sheet/build_info_card_widget.dart';
import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
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
        BuildInfoCardWidget(title: "RANK", value: "#${coin.rank}"),

        BuildInfoCardWidget(
          title: "MARKET CAP",
          value: _formatCurrency(coin.marketCap ?? '0'),
        ),

        BuildInfoCardWidget(
          title: "24H VOL",
          value: _formatCurrency(coin.volume24h),
        ),

        BuildInfoCardWidget(
          title: "ALL TIME HIGH",
          value:
              "\$${double.tryParse(coin.allTimeHigh.price ?? '0')?.toStringAsFixed(2) ?? '0.00'}",
        ),
      ],
    ).symmetricPadding(horizontal: context.width * 0.04);
  }

  // Verileri formatlamak için  metod
  String _formatCurrency(String? value) {
    if (value == null || value == '0') return "N/A";

    // Önce varsa virgülleri temizleyelim
    final cleanValue = value.replaceAll(',', '');
    double val = double.tryParse(cleanValue) ?? 0;

    if (val == 0) return "\$0.00";

    if (val >= 1e12) return "\$${(val / 1e12).toStringAsFixed(2)}T";
    if (val >= 1e9) return "\$${(val / 1e9).toStringAsFixed(2)}B";
    if (val >= 1e6) return "\$${(val / 1e6).toStringAsFixed(2)}M";

    // Eğer rakam 1000'den büyükse binlik ayracı ekleyelim (Opsiyonel)
    return "\$${val.toStringAsFixed(0)}";
  }
}
