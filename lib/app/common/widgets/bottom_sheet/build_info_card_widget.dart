import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:flutter/material.dart';

class BuildInfoCardWidget extends StatelessWidget {
  final String title;
  final String value;

  const BuildInfoCardWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cloudyBlue.withAlpha(50),
        border: Border.all(color: AppColor.cloudyBlue.withAlpha(20)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColor.skyBlue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColor.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
