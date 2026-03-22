import 'package:equatable/equatable.dart';

class PaginationModel extends Equatable {
  final int limit;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String? nextCursor;
  final String? previousCursor;

  const PaginationModel({
    required this.limit,
    required this.hasNextPage,
    required this.hasPreviousPage,
    this.nextCursor,
    this.previousCursor,
  });

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      limit: (map['limit'] as num).toInt(),
      hasNextPage: map['hasNextPage'] as bool? ?? false,
      hasPreviousPage: map['hasPreviousPage'] as bool? ?? false,
      nextCursor: map['nextCursor'] as String?, 
      previousCursor: map['previousCursor'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    limit,
    hasNextPage,
    hasPreviousPage,
    nextCursor,
    previousCursor,
  ];
}
