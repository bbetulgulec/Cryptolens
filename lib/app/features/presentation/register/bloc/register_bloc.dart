import 'package:crypto_lens/app/common/constants/app_strings.dart';
import 'package:crypto_lens/app/features/data/repository/auth_repository.dart';
import 'package:crypto_lens/app/features/presentation/register/bloc/register_event.dart';
import 'package:crypto_lens/app/features/presentation/register/bloc/register_state.dart';
import 'package:crypto_lens/core/helpers/error_message_helper.dart';
import 'package:crypto_lens/core/result/result.dart';
import 'package:crypto_lens/core/widgets/snackbar/app_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;
  RegisterBloc(this._authRepository)
    : super(
        const RegisterState(
          email: '',
          password: '',
          passwordAgain: '',
          isLoading: false,
          isSuccessfull: false,
        ),
      ) {
    on<RegisterFieldChanged>((event, emit) {
      emit(
        state.copyWith(
          email: event.email ?? state.email,
          password: event.password ?? state.password,
          passwordAgain: event.passwordAgain ?? state.passwordAgain,
        ),
      );
    });
    on<RegisterSubmitted>((event, emit) async {
      try {
        if (state.password != state.passwordAgain) {
          AppSnackBar.show(AppStrings.passwordsDontMatch);
          return;
        }
        emit(state.copyWith(isLoading: true, isSuccessfull: false));

        final result = await _authRepository.register(
          state.email,
          state.password,
        );

        if (result is SuccessDataResult) {
          emit(state.copyWith(isLoading: false, isSuccessfull: true));
          AppSnackBar.show(ErrorMessageHelper.parse(AppStrings.accountCreated));
        } else {
          AppSnackBar.show(ErrorMessageHelper.parse(result.message ?? ''));
          emit(state.copyWith(isLoading: false));
        }
      } catch (e) {
        AppSnackBar.show(ErrorMessageHelper.parse(e.toString()));
        emit(state.copyWith(isLoading: false));
      }
    });
  }
}
