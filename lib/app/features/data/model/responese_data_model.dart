import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:crypto_lens/app/features/data/model/stats_model.dart';
import 'package:equatable/equatable.dart';

class ResponseDataModel extends Equatable {
  final StatsModel stats;
  final List<CoinsModel> coins;

  const ResponseDataModel({required this.stats, required this.coins});

  factory ResponseDataModel.fromMap(Map<String, dynamic> map) {
    return ResponseDataModel(
      stats: StatsModel.fromMap(map['stats'] as Map<String, dynamic>),
      coins: (map['coins'] as List)
          .map((coinMap) => CoinsModel.fromMap(coinMap as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [stats, coins];
}
