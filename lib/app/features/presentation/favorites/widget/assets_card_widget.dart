import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/coin_icon_widget.dart';
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
    final Color ratioColor = ratio.startsWith('-') ? Colors.red : Colors.green;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppColor.midnightBlue,
        elevation: 4,
        child: Row(
          children: [
            CoinIconWidget(),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextWidget.medium(name, color: AppColor.white),
                  AppTextWidget.regular(
                    nameAbb,
                    color: AppColor.white.withAlpha(60),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextWidget.medium(dolarText, color: AppColor.white),
                  AppTextWidget.regular(ratio, color: ratioColor),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onFavoriteTap, 
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.amber : AppColor.white,
                size: 24,
              ),
            ),
          ],
        ).allPadding(context.height * 0.015),
      ),
    );
  }
}
