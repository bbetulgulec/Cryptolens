import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColor.electricBlue, AppColor.modernViolet],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: AppTextWidget.bold("CryptoLens", size: 28),
    );
  }
}
