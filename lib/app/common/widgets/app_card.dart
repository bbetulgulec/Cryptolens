import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/enum/app_image.dart';
import 'package:crypto_lens/app/common/widgets/app_button_gradient.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:crypto_lens/app/common/widgets/app_textField.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String titleDesc;
  final String emailText;
  final String passwordText;
  final String? againPasswordText;
  final String? buttonText;
  final String richTextFirst;
  final String richTextSecond;

  const AppCard({
    super.key,
    required this.title,
    required this.titleDesc,
    required this.emailText,
    required this.passwordText,
    this.buttonText,
    required this.richTextFirst,
    required this.richTextSecond,
    this.againPasswordText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: AppColor.midnightBlue,
      elevation: 4,
      child:
          Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              AppText.bold(title, color: AppColor.white),

              AppText.medium(titleDesc, color: AppColor.skyBlue),
              SizedBox(height: context.height * 0.08),
              AppTextField(text: emailText),
              SizedBox(height: context.height * 0.05),
              AppTextField(text: passwordText),
              SizedBox(height: context.height * 0.05),
              if (againPasswordText != null) ...[
                AppTextField(text: againPasswordText!),
              ],
              SizedBox(height: context.height * 0.05),

              AppButtonGradient(buttonText: buttonText),

              SizedBox(height: context.height * 0.03),
              RichText(
                text: TextSpan(
                  text: richTextFirst,
                  style: const TextStyle(color: AppColor.skyBlue),
                  children: <TextSpan>[
                    TextSpan(
                      text: richTextSecond,
                      style: const TextStyle(
                        color: AppColor.cornflowerPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).symmetricPadding(
            horizontal: context.width * 0.05,
            vertical: context.height * 0.09,
          ),
    );
  }
}
