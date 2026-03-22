import 'package:crypto_lens/app/features/data/model/allTimeHigh_model.dart';
import 'package:equatable/equatable.dart';

class CoinsModel extends Equatable {
  final String uuid;
  final String symbol;
  final String name;
  final String? color;
  final String iconUrl;
  final String? marketCap;
  final String price;
  final int? listedAt;
  final int? tier;
  final String change;
  final int rank;
  final List<String> sparkline;
  final AlltimehighModel allTimeHigh;
  final bool? lowVolume;
  final String? coinrankingUrl;
  final String volume24h;
  final String? btcPrice;
  final List? contractAddresses;
  final bool? isWrappedTrustless;
  final bool? wrappedTo;

  const CoinsModel({
    required this.uuid,
    required this.symbol,
    required this.name,
    required this.color,
    required this.iconUrl,
    this.marketCap,
    required this.price,
    this.listedAt,
    this.tier,
    required this.change,
    required this.rank,
    required this.sparkline,
    required this.allTimeHigh,
    this.lowVolume,
    this.coinrankingUrl,
    required this.volume24h,
    this.btcPrice,
    this.contractAddresses,
    this.isWrappedTrustless,
    this.wrappedTo,
  });

  factory CoinsModel.fromMap(Map<String, dynamic> map) {
    return CoinsModel(
      uuid: map['uuid'] as String,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      color: map['color'] as String?,
      iconUrl: map['iconUrl'] as String,
      price: map['price'] as String,
      change: map['change'] as String,
      rank: map['rank'] as int,
      sparkline: List<String>.from(map['sparkline'] ?? []),
      allTimeHigh: AlltimehighModel.fromMap(map['allTimeHigh']),
      volume24h: map['24hVolume'] as String,
    );
  }
  @override
  List<Object?> get props => [
    uuid,
    symbol,
    name,
    color,
    iconUrl,
    marketCap,
    price,
    listedAt,
    tier,
    change,
    rank,
    sparkline,
    allTimeHigh,
    lowVolume,
    coinrankingUrl,
    volume24h,
    btcPrice,
    contractAddresses,
    isWrappedTrustless,
    wrappedTo,
  ];
}
