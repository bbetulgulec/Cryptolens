import 'package:equatable/equatable.dart';

class AlltimehighModel extends Equatable {
  final String? price;
  final int? timestamp;

  const AlltimehighModel({this.price, this.timestamp});
  factory AlltimehighModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const AlltimehighModel(price: '0', timestamp: 0);

    return AlltimehighModel(
      price: map['price']?.toString() ?? '0',
      timestamp: map['timestamp'] as int? ?? 0,
    );
  }
  @override
  List<Object?> get props => [price, timestamp];
}
