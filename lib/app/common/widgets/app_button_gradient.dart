import 'package:crypto_lens/app/common/enum/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppButtonGradient extends StatelessWidget {
  const AppButtonGradient({super.key, required this.buttonText});

  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColor.modernViolet, AppColor.electricBlue],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: AppText.medium(buttonText ?? "", color: AppColor.white),
        ),
      ),
    );
  }
}
