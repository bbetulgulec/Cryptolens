
import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:flutter/material.dart';

class UpperLimitText extends StatelessWidget {
  const UpperLimitText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.electricBlue.withAlpha(50),
        border: Border.all(color: AppColor.electricBlue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.trending_up, color: AppColor.neonBlue),
          AppText.regular("+2.4%", color: AppColor.neonBlue),
        ],
      ),
    );
  }
}
