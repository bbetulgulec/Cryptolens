import 'package:crypto_lens/app/features/data/repository/auth_repository.dart';
import 'package:crypto_lens/app/features/presentation/register/bloc/register_event.dart';
import 'package:crypto_lens/app/features/presentation/register/bloc/register_state.dart';
import 'package:crypto_lens/core/result/result.dart';
import 'package:flutter/rendering.dart';
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
      debugPrint("REGISTER TIKLANDI");
      try {
        if (state.password != state.passwordAgain) {
          emit(state.copyWith(errorMessage: "Passwords do not match!"));
          return;
        }
        emit(
          state.copyWith(
            isLoading: true,
            errorMessage: null,
            isSuccessfull: false,
          ),
        );
        final result = await _authRepository.register(
          state.email,
          state.password,
        );
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
