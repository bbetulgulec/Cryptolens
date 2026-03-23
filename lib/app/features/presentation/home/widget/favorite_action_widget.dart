import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:flutter/material.dart';

class FavoriteActionWidget extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onTap;

  const FavoriteActionWidget({required this.isFavorite, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isFavorite ? Icons.star : Icons.star_border,
        color: isFavorite ? AppColor.amber : AppColor.white,
        size: 24,
      ),
    );
  }
}