import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/build_responsive_icon_widget.dart';
import 'package:flutter/material.dart';

class BottomSheetTitleRowWidget extends StatelessWidget {
  final String iconPath;
  final String name;
  final String symbol;

  const BottomSheetTitleRowWidget({
    super.key,
    required this.iconPath,
    required this.name,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        BuildResponsiveIconWidget(url: iconPath),
        RichText(
          text: TextSpan(
            text: name,
            style: const TextStyle(color: AppColor.white, fontSize: 25),
            children: <TextSpan>[
              TextSpan(
                text: '  |  ',
                style: const TextStyle(color: AppColor.white),
              ),
              TextSpan(
                text: symbol,
                style: const TextStyle(
                  color: AppColor.skyBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
