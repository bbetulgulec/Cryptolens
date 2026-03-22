import 'package:crypto_lens/app/features/data/repository/auth_repository.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_event.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AuthRepository _authRepository;
  MainBloc(this._authRepository)
    : super(MainState(logoutSuccessful: false, isLoading: false)) {
    on<MainTabChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
    on<Logout>((event, emit) {
      emit(state.copyWith(logoutSuccessful: false, isLoading: true));
      try {
        _authRepository.logout();
        emit(state.copyWith(logoutSuccessful: true, isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });
  }
}
