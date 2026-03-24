import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class FetchHomeData extends HomeEvent {
  final bool isRefresh;
  const FetchHomeData({this.isRefresh = false});
}

class FetchCoinDetail extends HomeEvent {
  final String uuid;
  final String time;

  const FetchCoinDetail({required this.uuid, required this.time});

  @override
  List<Object?> get props => [uuid, time];
}

class HomeToggleFavorite extends HomeEvent {
  final String uuid;

  HomeToggleFavorite({required this.uuid});
}

class Filtered extends HomeEvent {
  final String orderBy;
  final String orderDirection;
  const Filtered({required this.orderBy, required this.orderDirection});

  @override
  List<Object?> get props => [orderBy, orderDirection];
}

class SearchCoins extends HomeEvent {
  final String query;

  const SearchCoins(this.query);

  @override
  List<Object?> get props => [query];
}
