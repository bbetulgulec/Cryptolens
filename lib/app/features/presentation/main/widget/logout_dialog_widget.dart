import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';
import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';

class LogoutDialogWidget extends StatelessWidget {
  final VoidCallback onChanged;
  const LogoutDialogWidget({super.key, required this.onChanged});

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onChanged,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          LogoutDialogWidget(onChanged: onChanged), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.midnightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout_rounded, color: AppColor.red, size: 40),
              SizedBox(height: context.height * 0.04),
              AppTextWidget.bold("Logout", color: AppColor.white),
              SizedBox(height: context.height * 0.01),

              AppTextWidget.medium(
                "Are you sure you want to log out?",
                color: AppColor.cloudyBlue,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.height * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: AppTextWidget.semiBold(
                      "Cancel",
                      color: AppColor.cloudyBlue,
                    ),
                  ),
                  // Çıkış Butonu
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.red.withAlpha(15),
                      side: const BorderSide(color: AppColor.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onChanged,
                    child: AppTextWidget.semiBold(
                      "Logout",
                      color: AppColor.red,
                    ),
                  ),
                ],
              ),
            ],
          ).symmetricPadding(
            horizontal: context.width * 0.06,
            vertical: context.height * 0.04,
          ),
    );
  }
}
