import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

class AppButtonGradientWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const AppButtonGradientWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

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
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: AppTextWidget.medium(buttonText ?? "", color: AppColor.white),
        ),
      ),
    );
  }
}
