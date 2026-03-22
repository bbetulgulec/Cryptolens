import 'package:equatable/equatable.dart';

class AlltimehighModel extends Equatable {
  final String? price;
  final int? timestamp;

  // Constructor'ı şu şekilde sadeleştir:
  const AlltimehighModel({this.price, this.timestamp});
  // all_time_high_model.dart
  factory AlltimehighModel.fromMap(Map<String, dynamic>? map) {
    // Eğer map komple null gelirse boş bir model döndür
    if (map == null) return const AlltimehighModel(price: '0', timestamp: 0);

    return AlltimehighModel(
      price: map['price']?.toString() ?? '0',
      timestamp: map['timestamp'] as int? ?? 0,
    );
  }
  @override
  List<Object?> get props => [price, timestamp];
}
