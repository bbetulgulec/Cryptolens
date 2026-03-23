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
      limit: int.tryParse(map['limit']?.toString() ?? '50') ?? 50,
      hasNextPage: map['hasNextPage'] == true,
      hasPreviousPage: map['hasPreviousPage'] == true,
      nextCursor: map['nextCursor']?.toString(),
      previousCursor: map['previousCursor']?.toString(),
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
