import 'package:crypto_lens/app/features/presentation/main/bloc/main_event.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    

    on<MainTabChanged>((event, emit) {

      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}