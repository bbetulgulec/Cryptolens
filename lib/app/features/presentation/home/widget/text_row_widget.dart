import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:flutter/material.dart';

class TextRowWidget extends StatelessWidget {
  final String total24hVolume;
  const TextRowWidget({super.key, required this.total24hVolume});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        AppText.big("Live Assets", color: AppColor.white),
        AppText.medium(total24hVolume, color: AppColor.neonBlue),
      ],
    );
  }
}
