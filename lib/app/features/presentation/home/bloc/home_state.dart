import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:crypto_lens/app/features/data/model/stats_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<CoinsModel> coins;
  final StatsModel? stats;
  final String? errorMessage;
  final bool isBottomSheetLoading;
  final CoinsModel? coinDetail;
  final String? selectedTime;

  const HomeState({
    required this.isLoading,
    this.coins = const [],
    this.stats,
    this.errorMessage,
    this.isBottomSheetLoading = false,
    this.coinDetail, this.selectedTime,
  });

  factory HomeState.initial() {
    return const HomeState(
      isLoading: false,
      coins: [],
      stats: null,
      errorMessage: null,
      isBottomSheetLoading: false,
      coinDetail: null,
      selectedTime: "7d",
    );
  }

  HomeState copyWith({
    bool? isLoading,
    List<CoinsModel>? coins,
    StatsModel? stats,
    String? errorMessage,
    bool? isBottomSheetLoading,
    CoinsModel? coinDetail,
    String? selectedTime,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      coins: coins ?? this.coins,
      stats: stats ?? this.stats,
      errorMessage: errorMessage,
      isBottomSheetLoading: isBottomSheetLoading ?? this.isBottomSheetLoading,
      coinDetail: coinDetail ?? this.coinDetail,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    coins,
    stats,
    errorMessage,
    isBottomSheetLoading,
    coinDetail,
    selectedTime,
  ];
}
