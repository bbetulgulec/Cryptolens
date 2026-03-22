import 'package:crypto_lens/app/common/enum/app_image.dart';
import 'package:crypto_lens/app/common/get_it/get_it.dart';
import 'package:crypto_lens/app/common/widgets/app_card.dart';
import 'package:crypto_lens/app/features/presentation/login/bloc/login_bloc.dart';
import 'package:crypto_lens/app/features/presentation/login/bloc/login_event.dart';
import 'package:crypto_lens/app/features/presentation/login/bloc/login_state.dart';
import 'package:crypto_lens/app/features/presentation/login/widget/title_text.dart';
import 'package:crypto_lens/app/features/presentation/main/view/main_view.dart';
import 'package:crypto_lens/app/features/presentation/register/view/register_view.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart'; // context.width için gerekli
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:crypto_lens/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:crypto_lens/core/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => getIt<LoginBloc>(),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccessfull) {
              AppLogger.instance.log("Giriş gerçekten başarılı!");
              Navigation.pushReplace(page: const MainView());
            }
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.height * 0.1),
                  Image.asset(
                    AppImage.appIcon.path,
                    width: context.width * 0.2,
                    height: context.width * 0.2,
                    fit: BoxFit.contain,
                  ),
                  const TitleText(),

                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),

                  AppCard(
                    title: "Welcome",
                    titleDesc: "Access your secure digital vault",
                    emailText: "Email Address : ",
                    passwordText: "Password : ",
                    buttonText: "Login",
                    richTextFirst: 'New to The CryptoLens?',
                    richTextSecond: '  Create Account',

                    onEmailChanged: (val) {
                      context.read<LoginBloc>().add(
                        LoginFieldChanged(email: val),
                      );
                    },
                    onPasswordChanged: (val) {
                      context.read<LoginBloc>().add(
                        LoginFieldChanged(password: val),
                      );
                    },
                    onPressed: () {
                      context.read<LoginBloc>().add(const Logined());
                    },
                    onTap: () {
                      AppLogger.instance.log(
                        "redirected to the registration page",
                      );
                      Navigation.push(page: const RegisterView());
                    },
                  ),
                ],
              ).onlyPadding(top: context.height * 0.04),
            );
          },
        ),
      ),
    );
  }
}
