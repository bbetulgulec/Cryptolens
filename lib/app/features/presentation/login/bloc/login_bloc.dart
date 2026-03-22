import 'package:crypto_lens/app/features/data/repository/auth_repository.dart';
import 'package:crypto_lens/app/features/presentation/login/bloc/login_event.dart';
import 'package:crypto_lens/app/features/presentation/login/bloc/login_state.dart';
import 'package:crypto_lens/core/result/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc(this._authRepository)
    : super(
        const LoginState(
          email: '',
          password: '',
          isLoading: false,
          isSuccessfull: false,
        ),
      ) {
    on<LoginFieldChanged>((event, emit) {
      emit(
        state.copyWith(
          email: event.email ?? state.email,
          password: event.password ?? state.password,
          errorMessage: null,
        ),
      );
    });
    on<Logined>((event, emit) async {
      debugPrint("Logied TIKLANDI. Email: ${state.email}");
      try {
        if (state.email.isEmpty || state.password.isEmpty) {
          emit(
            state.copyWith(errorMessage: "Please enter email and password."),
          );
          return;
        }
        emit(
          state.copyWith(
            isLoading: true,
            errorMessage: null,
            isSuccessfull: false,
          ),
        );
        final result = await _authRepository.login(state.email, state.password);
        if (result is SuccessDataResult) {
          emit(state.copyWith(isLoading: false, isSuccessfull: true));
          return;
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: result.message));
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });
  }
}
