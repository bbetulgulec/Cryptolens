import 'package:crypto_lens/app/common/enum/app_image.dart';
import 'package:crypto_lens/app/common/widgets/app_card.dart';
import 'package:crypto_lens/app/features/presentation/login/widget/title_text.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:crypto_lens/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:crypto_lens/core/logger/app_logger.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImage.appIcon.path,
            width: context.width * 0.2,
            height: context.width * 0.2,
            fit: BoxFit.contain,
          ),
          TitleText(),
          AppCard(
            title: "Create Account",
            titleDesc: "Join the future of digital assets.",
            emailText: "Email Address : ",
            passwordText: "Password : ",
            againPasswordText: "Password (Repeat) : ",
            buttonText: "Register",
            richTextFirst: 'Already have an account? ',
            richTextSecond: '  Login',
            onPressed: () => {},
            onTap: () {
              AppLogger.instance.log("redirected to the login page");
              Navigation.ofPop();
            },
          ),
        ],
      ).onlyPadding(top: context.height * 0.04),
    );
  }
}
