// Fiyat ve Değişim Oranı Bölümü
import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

class PriceSection extends StatelessWidget {
  final String price;
  final String ratio;

  const PriceSection({required this.price, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final Color ratioColor = ratio.startsWith('-')
        ? AppColor.red
        : AppColor.green;

    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextWidget.medium(price, color: AppColor.white),
          AppTextWidget.regular(ratio, color: ratioColor),
        ],
      ),
    );
  }
}

// İsim ve Sembol Bölümü
class CoinInfoSection extends StatelessWidget {
  final String name;
  final String symbol;

  const CoinInfoSection({required this.name, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget.medium(name, color: AppColor.white),
          AppTextWidget.regular(symbol, color: AppColor.white.withAlpha(60)),
        ],
      ),
    );
  }
}
