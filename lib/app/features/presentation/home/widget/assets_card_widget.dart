import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/coin_icon_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/favorite_action_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/pricesection__coininfosection.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';

class AssetsCardWidget extends StatelessWidget {
  final String? url;
  final String name;
  final String nameAbb;
  final String dolarText;
  final String ratio;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const AssetsCardWidget({
    super.key,
    this.url,
    required this.name,
    required this.nameAbb,
    required this.dolarText,
    required this.ratio,
    this.onTap,
    required this.isFavorite,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppColor.midnightBlue,
        elevation: 4,
        child: Row(
          children: [
            CoinIconWidget(url: url),
            SizedBox(width: context.width * 0.03),
            CoinInfoSection(name: name, symbol: nameAbb),
            PriceSection(price: dolarText, ratio: ratio),
            SizedBox(width: context.width * 0.03),
            FavoriteActionWidget(isFavorite: isFavorite, onTap: onFavoriteTap),
          ],
        ).allPadding(context.height * 0.015),
      ),
    );
  }
}
