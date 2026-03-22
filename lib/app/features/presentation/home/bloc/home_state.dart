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
  final List<String> favoriteUuids;
  final bool successfullFiltered;
  // YENİ EKLENENLER: UI'daki seçimleri hafızada tutmak için
  final String orderBy;
  final String orderDirection;

  const HomeState({
    required this.isLoading,
    this.coins = const [],
    this.stats,
    this.errorMessage,
    this.isBottomSheetLoading = false,
    this.coinDetail,
    this.selectedTime,
    required this.favoriteUuids,
    required this.successfullFiltered,
    this.orderBy = 'marketCap', // Varsayılan değerler
    this.orderDirection = 'desc',
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
      favoriteUuids: [],
      successfullFiltered: false,
      orderBy: 'marketCap', // Başlangıçta marketCap seçili gelsin
      orderDirection: 'desc',
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
    List<String>? favoriteUuids,
    bool? successfullFiltered,
    String? orderBy,
    String? orderDirection,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      coins: coins ?? this.coins,
      stats: stats ?? this.stats,
      errorMessage: errorMessage ?? this.errorMessage,
      isBottomSheetLoading: isBottomSheetLoading ?? this.isBottomSheetLoading,
      coinDetail: coinDetail ?? this.coinDetail,
      selectedTime: selectedTime ?? this.selectedTime,
      favoriteUuids: favoriteUuids ?? this.favoriteUuids,
      successfullFiltered: successfullFiltered ?? this.successfullFiltered,
      orderBy: orderBy ?? this.orderBy, // Güncelleneni al yoksa mevcut kalsın
      orderDirection: orderDirection ?? this.orderDirection,
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
    favoriteUuids,
    successfullFiltered,
    orderBy,
    orderDirection,
  ];
}
