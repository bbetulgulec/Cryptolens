import 'package:crypto_lens/app/common/enum/app_image.dart';
import 'package:crypto_lens/app/common/get_it/get_it.dart';
import 'package:crypto_lens/app/common/widgets/app_card_widget.dart';
import 'package:crypto_lens/app/common/widgets/title_text_widget.dart';
import 'package:crypto_lens/app/features/presentation/register/bloc/register_bloc.dart';
import 'package:crypto_lens/app/features/presentation/register/bloc/register_event.dart';
import 'package:crypto_lens/app/features/presentation/register/bloc/register_state.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:crypto_lens/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:crypto_lens/core/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => getIt<RegisterBloc>(),
      child: Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isSuccessfull) Navigation.ofPop();
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.appIcon.path,
                  width: context.width * 0.2,
                  height: context.width * 0.2,
                  fit: BoxFit.contain,
                ),

                TitleTextWidget(),

                AppCardWidget(
                  title: "Create Account",
                  titleDesc: "Join the future of digital assets.",
                  emailText: "Email Address : ",
                  passwordText: "Password : ",
                  againPasswordText: "Password (Repeat) : ",
                  buttonText: "Register",
                  richTextFirst: 'Already have an account? ',
                  richTextSecond: '  Login',
                  onEmailChanged: (val) => context.read<RegisterBloc>().add(
                    RegisterFieldChanged(email: val),
                  ),
                  onPasswordChanged: (val) => context.read<RegisterBloc>().add(
                    RegisterFieldChanged(password: val),
                  ),
                  onPasswordAgainChanged: (val) => context
                      .read<RegisterBloc>()
                      .add(RegisterFieldChanged(passwordAgain: val)),
                  onPressed: () {
                    context.read<RegisterBloc>().add(const RegisterSubmitted());
                  },
                  onTap: () {
                    AppLogger.instance.log("redirected to the login page");
                    Navigation.ofPop();
                  },
                ),
              ],
            ).onlyPadding(top: context.height * 0.06);
          },
        ),
      ),
    );
  }
}
