import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';

class AssetsCardWidget extends StatelessWidget {
  final VoidCallback onTap;
  const AssetsCardWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColor.midnightBlue,
        elevation: 4,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.ac_unit),
            SizedBox(width: context.width * 0.06),
            Column(
              children: [
                AppText.medium("Bitcoin", color: AppColor.white),
                AppText.medium("BTC", color: AppColor.white),
              ],
            ),
            Spacer(),
            Column(
              children: [
                AppText.medium("\$864.7784", color: AppColor.white),
                AppText.medium("+2.4%", color: AppColor.white),
              ],
            ),
          ],
        ).allPadding(context.height * 0.02),
      ),
    );
  }
}
