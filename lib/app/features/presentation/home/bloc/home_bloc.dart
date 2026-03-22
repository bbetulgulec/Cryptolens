import 'package:crypto_lens/app/features/data/model/responese_data_model.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_event.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_state.dart';
import 'package:crypto_lens/app/features/data/repository/coins_repository.dart';
import 'package:crypto_lens/core/result/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CoinsRepository _coinsRepository;

  HomeBloc(this._coinsRepository) : super(HomeState.initial()) {
    on<FetchHomeData>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      // 2. Repository üzerinden isteği at
      final result = await _coinsRepository.fetchLiveAssetsData(
        refresh: event.isRefresh,
      );

      if (result is SuccessDataResult) {
        final responseData = result.data?.data as ResponseDataModel?;

        if (responseData != null) {
          emit(
            state.copyWith(
              isLoading: false,
              coins: responseData.coins, 
              stats: responseData.stats,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: "Data format is incorrect.",
            ),
          );
        }
      } else if (result is ErrorDataResult) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: result.message ?? "An error occurred",
          ),
        );
      }
    });
  }
}
