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

class FetchCoinDetail extends FavoritesEvent {
  final String uuid;
  final String time;

  const FetchCoinDetail({required this.uuid, required this.time});

  @override
  List<Object?> get props => [uuid, time];
}

class ToggleFavorite extends FavoritesEvent {
  final String uuid;

  const ToggleFavorite({required this.uuid});

  @override
  List<Object?> get props => [uuid];
}
