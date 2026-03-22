import 'package:crypto_lens/app/features/data/model/pagination_model.dart';
import 'package:crypto_lens/app/features/data/model/responese_data_model.dart';
import 'package:equatable/equatable.dart';

class ResponseModel extends Equatable {
  final String status;
  final ResponseDataModel? data;
  final PaginationModel pagination;

  const ResponseModel({
    required this.status,
    this.data,
    required this.pagination,
  });

  ResponseModel copyWith({
    String? status,
    ResponseDataModel? data,
    PaginationModel? pagination,
  }) {
    return ResponseModel(
      status: status ?? this.status,
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: map['status'] as String? ?? 'fail',
      // Artık data null gelebilir, hata vermez:
      data: map['data'] != null
          ? ResponseDataModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      pagination: PaginationModel.fromMap(
        map['pagination'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {'status': status, 'data': data, 'pagination': pagination};
  }

  @override
  List<Object?> get props => [status, data, pagination];
}
