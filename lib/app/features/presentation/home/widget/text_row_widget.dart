import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:flutter/material.dart';

class TextRowWidget extends StatelessWidget {
  const TextRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        AppText.big("Live Assets", color: AppColor.white),
        AppText.medium("24h Vol: \$4.2B", color: AppColor.neonBlue),
      ],
    );
  }
}
