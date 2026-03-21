import 'package:crypto_lens/app/common/enum/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColor.electricBlue, AppColor.modernViolet],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: AppText.bold("CryptoLens", size: 28),
    );
  }
}
