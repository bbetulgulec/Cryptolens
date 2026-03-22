import 'package:equatable/equatable.dart';

class AlltimehighModel extends Equatable {
  final String? price;
  final int? timestamp;

  const AlltimehighModel({required this.price, required this.timestamp});

  factory AlltimehighModel.fromMap(Map<String, dynamic> map) {
    return AlltimehighModel(
      price: map['price'] as String?,
      timestamp: map['timestamp'] as int?,
    );
  }
  @override
  List<Object?> get props => [price, timestamp];
}
