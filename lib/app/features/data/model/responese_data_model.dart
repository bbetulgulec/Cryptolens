import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:crypto_lens/app/features/data/model/stats_model.dart';
import 'package:equatable/equatable.dart';

class ResponseDataModel extends Equatable {
  final StatsModel stats;
  final List<CoinsModel> coins;

  const ResponseDataModel({required this.stats, required this.coins});

  // ResponseDataModel.fromMap içini şu şekilde değiştir:
  factory ResponseDataModel.fromMap(Map<String, dynamic> map) {
    return ResponseDataModel(
      stats: map['stats'] != null
          ? StatsModel.fromMap(map['stats'] as Map<String, dynamic>)
          : const StatsModel(
              total: 0,
              totalCoins: 0,
              totalMarkets: 0,
              totalExchanges: 0,
              totalMarketCap: '0',
              total24hVolume: '0',
            ),
      coins:
          (map['coins'] as List?) // Listeyi nullable olarak al
              ?.map(
                (coinMap) =>
                    CoinsModel.fromMap(coinMap as Map<String, dynamic>),
              )
              .toList() ?? // Liste null ise boş liste döndür
          [],
    );
  }

  @override
  List<Object?> get props => [stats, coins];
}
