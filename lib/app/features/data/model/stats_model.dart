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

  factory StatsModel.fromMap(Map<String, dynamic> map) {
    return StatsModel(
      // map['total'] gelmeyebilir veya string gelebilir, garantiye alalım:
      total: int.tryParse(map['total']?.toString() ?? '0') ?? 0,
      totalCoins: int.tryParse(map['totalCoins']?.toString() ?? '0') ?? 0,
      totalMarkets: int.tryParse(map['totalMarkets']?.toString() ?? '0') ?? 0,
      totalExchanges:
          int.tryParse(map['totalExchanges']?.toString() ?? '0') ?? 0,
      // Bunlar zaten String ama null kontrolü ekleyelim:
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
