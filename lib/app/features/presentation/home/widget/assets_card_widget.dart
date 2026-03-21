import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';

class AssetsCardWidget extends StatelessWidget {
  const AssetsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: AppColor.midnightBlue,
      elevation: 4,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.ac_unit),
          Column(
            children: [
              AppText.medium("Bitcoin", color: AppColor.white),
              AppText.medium("BTC", color: AppColor.white),
            ],
          ),
          Column(
            children: [
              AppText.medium("\$864.7784", color: AppColor.white),
              AppText.medium("+2.4%", color: AppColor.white),
            ],
          ),
          Icon(Icons.star),
        ],
      ).allPadding(context.height * 0.02),
    );
  }
}
