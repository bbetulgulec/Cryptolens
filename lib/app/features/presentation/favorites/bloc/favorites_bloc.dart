// DÜZELTME: Event tipini FavoritesEvent yapıyoruz
import 'package:crypto_lens/app/features/data/repository/coins_repository.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_event.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_state.dart';
import 'package:crypto_lens/core/result/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoriteState> {
  final CoinsRepository _coinsRepository;

  FavoritesBloc(this._coinsRepository)
    : super(
        const FavoriteState(
          isLoading: false,
          coins: [],
          favoriteUuids: [],
          errorMessage: "",
        ),
      ) {
    on<FetchFavoritesData>((event, emit) async {
      if (state.coins.isNotEmpty && !event.isRefresh) {
        return;
      }
      emit(state.copyWith(isLoading: true));

      final currentFavorites = _coinsRepository.getFavorites();
      final result = await _coinsRepository.fetchLiveAssetsData(
        refresh: event.isRefresh,
      );

      if (result is SuccessDataResult) {
        // 1. ADIM: Cast işlemi yaparak Dart'a bunun bir SuccessDataResult olduğunu garanti et
        final successResult = result as SuccessDataResult;

        // 2. ADIM: Veriye güvenli erişim
        final model = successResult.data;

        if (model != null) {
          // model.data kısmı da null olabilir mi? Eğer öyleyse oraya da bir ? koyalım
          final allCoins = model
              .data
              .coins; // Burada hala hata varsa model.data?.coins ?? [] yapabilirsin

          final onlyFavorites = allCoins
              .where((coin) => currentFavorites.contains(coin.uuid))
              .toList();

          emit(
            state.copyWith(
              isLoading: false,
              coins: onlyFavorites,
              favoriteUuids: currentFavorites,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: "Model boş"));
        }
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: "Yüklenemedi"));
      }
    });
    on<ToggleFavorite>((event, emit) async {
      // 1. Hive'ı güncelle
      await _coinsRepository.toggleFavorite(event.uuid);

      // 2. Favori sayfasında olduğumuz için, yıldıza basılan coini listeden ANINDA çıkaralım
      final updatedFavorites = _coinsRepository.getFavorites();
      final updatedCoins = state.coins
          .where((c) => updatedFavorites.contains(c.uuid))
          .toList();

      emit(
        state.copyWith(
          favoriteUuids: updatedFavorites,
          coins: updatedCoins, // Liste anlık daralsın
        ),
      );
    });
    // favorites_bloc.dart

    // favorites_bloc.dart

    on<FetchCoinDetail>((event, emit) async {
      // ESKİ VERİ HATASINI ÇÖZEN KISIM: Yeni istekte coinDetail'i null yapıyoruz
      emit(state.copyWith(isLoading: true, coinDetail: null));

      // Repository metodunu mevcut haliyle (sadece time ile) çağırıyoruz
      final result = await _coinsRepository.fetchCoinDetails(time: event.time);

      if (result is SuccessDataResult) {
        final responseData = result.data?.data;
        if (responseData != null) {
          // Yapıyı bozmadan, gelen listeden event'ten gelen uuid'ye sahip coini buluyoruz
          final selectedCoin = responseData.coins.firstWhere(
            (c) => c.uuid == event.uuid,
            orElse: () => responseData.coins.first,
          );

          emit(state.copyWith(isLoading: false, coinDetail: selectedCoin));
        }
      } else {
        emit(state.copyWith(isLoading: false));
      }
    });
  }
}
