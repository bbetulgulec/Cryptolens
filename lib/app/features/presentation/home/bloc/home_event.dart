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
