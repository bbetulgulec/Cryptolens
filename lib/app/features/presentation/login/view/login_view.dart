import 'package:crypto_lens/app/common/enum/app_image.dart';
import 'package:crypto_lens/app/common/widgets/app_card.dart';
import 'package:crypto_lens/app/features/presentation/login/widget/title_text.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
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
          ),
        ],
      ).onlyPadding(top: context.height * 0.04),
    );
  }
}
