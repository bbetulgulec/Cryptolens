import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_event.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

class FetchFavoritesData extends FavoritesEvent {
  final bool isRefresh;
  const FetchFavoritesData({this.isRefresh = false});
}

class FetchFavoriteCoinDetail extends FavoritesEvent {
  final String uuid;
  final String time;

  const FetchFavoriteCoinDetail({required this.uuid, required this.time});

  @override
  List<Object?> get props => [uuid, time];
}

class SyncWithHome extends FavoritesEvent {
  final List<CoinsModel> allCoins; // Home sayfasındaki tüm coinler

  const SyncWithHome(this.allCoins);

  @override
  List<Object?> get props => [allCoins];
}

class ToggleFavorite extends FavoritesEvent {
  final String uuid;

  const ToggleFavorite({required this.uuid});

  @override
  List<Object?> get props => [uuid];
}
