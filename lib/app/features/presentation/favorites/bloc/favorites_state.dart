import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final bool isLoading;
  final List<CoinsModel> coins;
  final CoinsModel? coinDetail;
  final List<String> favoriteUuids;
  final String errorMessage;
  final String selectedTime;
  
  const FavoriteState({
    required this.isLoading,
    required this.coins,
    this.coinDetail,
    required this.favoriteUuids,
    required this.errorMessage,
    required this.selectedTime,
  });

  FavoriteState copyWith({
    bool? isLoading,
    List<CoinsModel>? coins,
    String? errorMessage,
    CoinsModel? coinDetail,
    List<String>? favoriteUuids,
    String? selectedTime,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      coins: coins ?? this.coins,
      errorMessage: errorMessage ?? this.errorMessage,
      coinDetail: coinDetail ?? this.coinDetail,
      favoriteUuids: favoriteUuids ?? this.favoriteUuids,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
  
// FavoriteState sınıfının içine ekle:
factory FavoriteState.initial() {
  return const FavoriteState(
    isLoading: false,
    coins: [],
    favoriteUuids: [],
    errorMessage: "",
    selectedTime: "7d", 
  );
}
  @override
  List<Object?> get props => [
    isLoading,
    coins,
    errorMessage,
    coinDetail,
    favoriteUuids,
    selectedTime,
  ];
}
