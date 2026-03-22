import 'package:equatable/equatable.dart';

class StatsModel extends Equatable {
  final int total;
  final int totalCoins;
  final int totalMarkets;
  final int totalExchanges;
  final String totalMarketCap;
  final String total24hVolume;
  const StatsModel({
    required this.total,
    required this.totalCoins,
    required this.totalMarkets,
    required this.totalExchanges,
    required this.totalMarketCap,
    required this.total24hVolume,
  });

  // stats_model.dart
  factory StatsModel.fromMap(Map<String, dynamic> map) {
    return StatsModel(
      total: map['total'] as int? ?? 0,
      totalCoins: map['totalCoins'] as int? ?? 0,
      totalMarkets: map['totalMarkets'] as int? ?? 0,
      totalExchanges: map['totalExchanges'] as int? ?? 0,
      totalMarketCap: map['totalMarketCap']?.toString() ?? '0',
      total24hVolume: map['total24hVolume']?.toString() ?? '0',
    );
  }
  StatsModel copyWith({
    int? total,
    int? totalCoins,
    int? totalMarkets,
    int? totalExchanges,
    String? totalMarketCap,
    String? total24hVolume,
  }) {
    return StatsModel(
      total: total ?? this.total,
      totalCoins: totalCoins ?? this.totalCoins,
      totalMarkets: totalMarkets ?? this.totalMarkets,
      totalExchanges: totalExchanges ?? this.totalExchanges,
      totalMarketCap: totalMarketCap ?? this.totalMarketCap,
      total24hVolume: total24hVolume ?? this.total24hVolume,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'totalCoins': totalCoins,
      'totalMarkets': totalMarkets,
      'totalExchanges': totalExchanges,
      'totalMarketCap': totalMarketCap,
      'total24hVolume': total24hVolume,
    };
  }

  @override
  List<Object?> get props => [
    total,
    totalCoins,
    totalMarkets,
    totalExchanges,
    totalMarketCap,
    total24hVolume,
  ];
}
