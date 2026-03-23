import 'dart:ui';

import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class BuildBlurredIconWidget extends StatelessWidget {
  const BuildBlurredIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: context.width * 0.30,
          height: context.width * 0.30,
          decoration: BoxDecoration(
            color: AppColor.modernViolet.withAlpha(30),
            shape: BoxShape.circle,
          ),
        ),
        ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              width: context.width * 0.30,
              height: context.width * 0.30,
              color:
                  Colors.transparent, // İçini boş bırakıyoruz, sadece buğuluyor
            ),
          ),
        ),
        // 3. En üstteki İkon
        Icon(Icons.warning_rounded, size: 50, color: AppColor.modernViolet),
      ],
    );
  }
}
