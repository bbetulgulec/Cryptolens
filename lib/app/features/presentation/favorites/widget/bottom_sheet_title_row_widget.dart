import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';

class BottomSheetTitleRowWidget extends StatelessWidget {
  const BottomSheetTitleRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.abc),
        RichText(
          text: TextSpan(
            text: "Bitcoin",
            style: const TextStyle(color: AppColor.white, fontSize: 30),
            children: <TextSpan>[
              TextSpan(
                text: " BTC",
                style: const TextStyle(
                  color: AppColor.skyBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ).symmetricPadding(
      horizontal: context.width * 0.01,
      vertical: context.height * 0.02,
    );
  }
}
