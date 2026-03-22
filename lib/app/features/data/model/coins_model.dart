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
      uuid: map['uuid']?.toString() ?? '',
      symbol: map['symbol']?.toString() ?? 'N/A',
      name: map['name']?.toString() ?? 'Unknown',
      color: map['color']?.toString(),
      iconUrl: map['iconUrl']?.toString() ?? '',
      marketCap: map['marketCap']?.toString(),
      price: map['price']?.toString() ?? '0.0',
      contractAddresses: map['contractAddresses'] as List? ?? [],
      // GÜVENLİ DEĞİŞİM (Null gelirse '0' yap)
      change: map['change']?.toString() ?? '0',

      // GÜVENLİ RANK (Null gelirse 0 yap)
      rank: (map['rank'] is int)
          ? map['rank']
          : int.tryParse(map['rank']?.toString() ?? '0') ?? 0,

      sparkline:
          (map['sparkline'] as List?)
              ?.map((e) => e?.toString() ?? '0')
              .toList() ??
          [],
      // GÜVENLİ ALL TIME HIGH (Modelin içindeki fromMap'e null gitmesin)
      allTimeHigh: map['allTimeHigh'] != null
          ? AlltimehighModel.fromMap(map['allTimeHigh'])
          : const AlltimehighModel(price: '0', timestamp: 0),

      volume24h: map['24hVolume']?.toString() ?? '0',
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
