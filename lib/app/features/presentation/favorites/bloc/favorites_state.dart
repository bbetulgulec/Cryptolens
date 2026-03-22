import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final bool isLoading;
  final List<CoinsModel> coins;
  final CoinsModel? coinDetail;
  final List<String> favoriteUuids;
  final String errorMessage;

  const FavoriteState({
    required this.isLoading,
    required this.coins,
    this.coinDetail,
    required this.favoriteUuids,
    required this.errorMessage,
  });

  FavoriteState copyWith({
    bool? isLoading,
    List<CoinsModel>? coins,
    String? errorMessage,
    CoinsModel? coinDetail,
    List<String>? favoriteUuids,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      coins: coins ?? this.coins,
      errorMessage: errorMessage ?? this.errorMessage,
      coinDetail: coinDetail ?? this.coinDetail,
      favoriteUuids: favoriteUuids ?? this.favoriteUuids,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    coins,
    errorMessage,
    coinDetail,
    favoriteUuids,
  ];
}
