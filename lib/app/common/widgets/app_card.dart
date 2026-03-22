import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_button_gradient.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:crypto_lens/app/common/widgets/app_textfield.dart';
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
  final VoidCallback onPressed;
  final VoidCallback onTap;
  final Function(String)? onEmailChanged;
  final Function(String)? onPasswordChanged;
  final Function(String)? onPasswordAgainChanged;

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
    required this.onPressed,
    required this.onTap,
    this.onEmailChanged,
    this.onPasswordChanged,
    this.onPasswordAgainChanged,
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
              AppTextField(text: emailText, onChanged: onEmailChanged),
              SizedBox(height: context.height * 0.05),
              AppTextField(text: passwordText, onChanged: onPasswordChanged),
              SizedBox(height: context.height * 0.05),
              if (againPasswordText != null) ...[
                AppTextField(
                  text: againPasswordText!,
                  onChanged: onPasswordAgainChanged,
                ),
              ],
              SizedBox(height: context.height * 0.05),

              AppButtonGradient(buttonText: buttonText, onPressed: onPressed),

              SizedBox(height: context.height * 0.03),
              GestureDetector(
                onTap: onTap,
                child: RichText(
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
              ),
            ],
          ).symmetricPadding(
            horizontal: context.width * 0.05,
            vertical: context.height * 0.09,
          ),
    );
  }
}
