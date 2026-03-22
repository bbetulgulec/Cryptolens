import 'package:crypto_lens/app/common/enum/app_image.dart';
import 'package:crypto_lens/app/common/widgets/app_card.dart';
import 'package:crypto_lens/app/features/presentation/login/widget/title_text.dart';
import 'package:crypto_lens/app/features/presentation/register/view/register_view.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:crypto_lens/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:crypto_lens/core/logger/app_logger.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
            title: "Welcome",
            titleDesc: "Access your secure digital vault",
            emailText: "Email Address : ",
            passwordText: "Password : ",
            buttonText: "Login",
            richTextFirst: 'New to The CryptoLens?',
            richTextSecond: '  Create Account',
            onPressed: () {},
            onTap: () {
              AppLogger.instance.log("redirected to the registration page");
              Navigation.push(page: RegisterView());
            },
          ),
        ],
      ).onlyPadding(top: context.height * 0.04),
    );
  }
}
