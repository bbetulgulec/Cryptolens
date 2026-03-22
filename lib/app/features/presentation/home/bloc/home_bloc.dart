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

      final currentFavorites = _coinsRepository.getFavorites();
      emit(state.copyWith(favoriteUuids: currentFavorites));

      if (result is SuccessDataResult) {
        final responseData = result.data?.data;

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
    on<FetchCoinDetail>((event, emit) async {
      emit(
        state.copyWith(
          isBottomSheetLoading: true,
          selectedTime: event.time,
          errorMessage: null,
        ),
      );

      final result = await _coinsRepository.fetchCoinDetails(time: event.time);

      if (result is SuccessDataResult) {
        final responseData = result.data?.data as ResponseDataModel?;

        if (responseData != null && responseData.coins.isNotEmpty) {
          // KRİTİK NOKTA: Listenin başındakini değil,
          // event'ten gelen uuid'ye sahip olan coini buluyoruz.
          final selectedCoin = responseData.coins.firstWhere(
            (c) => c.uuid == event.uuid,
            orElse: () =>
                responseData.coins.first, // Bulamazsa mecburen ilkini al
          );

          emit(
            state.copyWith(
              isBottomSheetLoading: false,
              coinDetail: selectedCoin, // Artık doğru coin state'e geçti!
            ),
          );
        }
      } else {
        emit(state.copyWith(isBottomSheetLoading: false));
      }
    });
    on<ToggleFavorite>((event, emit) async {
      // 1. Mevcut favorileri kopyala (Referans hatası olmaması için toList() yapıyoruz)
      final List<String> currentFavorites = List.from(state.favoriteUuids);

      // 2. State'i ANINDA güncelle (Kullanıcı yıldıza bastığı saniye renk değişsin)
      if (currentFavorites.contains(event.uuid)) {
        currentFavorites.remove(event.uuid);
      } else {
        currentFavorites.add(event.uuid);
      }
      emit(state.copyWith(favoriteUuids: currentFavorites));

      // 3. Arka planda sessizce Hive'a kaydet (Await et ama emit bekleme)
      await _coinsRepository.toggleFavorite(event.uuid);
    });
    on<Filtered>((event, emit) async {
      // 1. Önce State'teki seçimleri güncelle ve loading başlat
      emit(
        state.copyWith(
          isLoading: true,
          orderBy: event.orderBy,
          orderDirection: event.orderDirection,
        ),
      );

      // 2. Repository'den yeni filtrelerle veriyi çek
      final result = await _coinsRepository.fetchLiveAssetsData(
        orderBy: event.orderBy,
        orderDirection: event.orderDirection,
      );

      // 3. Sonucu emit et (Success/Error durumuna göre)
      if (result is SuccessDataResult) {
        emit(
          state.copyWith(
            isLoading: false,
            coins: result.data?.data?.coins ?? [],
            successfullFiltered: !state.successfullFiltered,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: "Filtreleme başarısız",
          ),
        );
      }
    });
  }
}
