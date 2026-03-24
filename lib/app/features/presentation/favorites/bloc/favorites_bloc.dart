// DÜZELTME: Event tipini FavoritesEvent yapıyoruz
import 'package:crypto_lens/app/features/data/repository/coins_repository.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_event.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_state.dart';
import 'package:crypto_lens/core/result/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoriteState> {
  final CoinsRepository _coinsRepository;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  FavoritesBloc(this._coinsRepository) : super(FavoriteState.initial()) {
    {
      on<FetchFavoritesData>((event, emit) async {
        final currentFavorites = _coinsRepository.getFavorites();

        // 2. EĞER elinde zaten coin verisi varsa ve "Zorla Yenile (isRefresh)" denmediyse:
        // Sadece yereldeki listeyi filtrele ve API'ye HİÇ GİTME.
        if (state.coins.isNotEmpty && !event.isRefresh) {
          final onlyFavorites = state.coins
              .where((coin) => currentFavorites.contains(coin.uuid))
              .toList();

          emit(
            state.copyWith(
              isLoading: false,
              coins: onlyFavorites,
              favoriteUuids: currentFavorites,
            ),
          );
          return; // Fonksiyonu burada bitir, aşağıya (API'ye) geçme.
        }

        // 3. EĞER liste boşsa veya kullanıcı isRefresh: true gönderdiyse API'ye git
        emit(state.copyWith(isLoading: true));

        final result = await _coinsRepository.fetchLiveAssetsData(
          refresh: event.isRefresh,
        );

        if (result is SuccessDataResult) {
          final responseData = result.data?.data;

          if (responseData != null) {
            final allCoins = responseData.coins;

            // Gelen tüm coinler arasından sadece favorileri ayıkla
            final onlyFavorites = allCoins
                .where((coin) => currentFavorites.contains(coin.uuid))
                .toList();

            emit(
              state.copyWith(
                isLoading: false,
                coins: onlyFavorites, // Favori objelerini sakla
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
        // 1. Mevcut listeyi kopyala
        final List<String> currentFavorites = List.from(state.favoriteUuids);

        if (currentFavorites.contains(event.uuid)) {
          currentFavorites.remove(event.uuid);
        } else {
          currentFavorites.add(event.uuid);
        }

        final updatedCoins = state.coins
            .where((c) => currentFavorites.contains(c.uuid))
            .toList();

        emit(
          state.copyWith(favoriteUuids: currentFavorites, coins: updatedCoins),
        );

        // 3. Arka planda kaydet (await olabilir)
        await _coinsRepository.toggleFavorite(event.uuid);
      });

      on<FetchFavoriteCoinDetail>((event, emit) async {
        if (state.selectedTime == event.time &&
            state.coinDetail?.uuid == event.uuid) {
          return;
        }
        emit(state.copyWith(isLoading: true, selectedTime: event.time));

        final result = await _coinsRepository.fetchCoinDetails(
          time: event.time,
          uuid: event.uuid,
        );

        if (result is SuccessDataResult) {
          final responseData = result.data?.data;
          if (responseData != null && responseData.coins.isNotEmpty) {
            final selectedCoin = responseData.coins.firstWhere(
              (c) => c.uuid == event.uuid,
              orElse: () => responseData.coins.first,
            );
            emit(state.copyWith(isLoading: false, coinDetail: selectedCoin));
          }
        } else {
          emit(state.copyWith(isLoading: false));
        }
      }, transformer: debounce(const Duration(milliseconds: 400)));
      on<SyncWithHome>((event, emit) {
        // 1. Hive'dan güncel favori UUID'lerini al
        final currentFavorites = _coinsRepository.getFavorites();

        // 2. Home'dan gelen listeden favori olanları ayıkla
        final onlyFavorites = event.allCoins
            .where((coin) => currentFavorites.contains(coin.uuid))
            .toList();

        // 3. State'i güncelle (Sıfır internet harcaması!)
        emit(
          state.copyWith(
            coins: onlyFavorites,
            favoriteUuids: currentFavorites,
            isLoading: false,
          ),
        );
      });

      
    }
  }
}
