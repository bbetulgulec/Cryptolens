import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/constants/app_strings.dart';
import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
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
        AppTextWidget.bold(AppStrings.liveAssets, color: AppColor.white),
        AppTextWidget.medium(total24hVolume, color: AppColor.neonBlue),
      ],
    ).symmetricPadding(horizontal: context.width * 0.02);
  }
}
