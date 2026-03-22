import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:crypto_lens/app/features/data/model/stats_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<CoinsModel> coins; 
  final StatsModel? stats;
  final String? errorMessage;
  

  const HomeState({
    required this.isLoading,
    this.coins = const [],
    this.stats,
    this.errorMessage,
  });

  factory HomeState.initial() {
    return const HomeState(
      isLoading: false,
      coins: [],
      stats: null,
      errorMessage: null,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    List<CoinsModel>? coins,
    StatsModel? stats,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      coins: coins ?? this.coins,
      stats: stats ?? this.stats,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, coins, stats, errorMessage];
}
