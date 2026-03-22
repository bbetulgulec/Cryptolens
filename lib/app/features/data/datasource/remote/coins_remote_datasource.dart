import 'package:crypto_lens/app/common/config/config.dart';
import 'package:crypto_lens/app/features/data/model/response_model.dart';
import 'package:crypto_lens/core/dio_manager/api_error_model.dart';
import 'package:crypto_lens/core/dio_manager/api_response_model.dart';
import 'package:crypto_lens/core/dio_manager/dio_manager.dart';

abstract class CoinsRemoteDatasource {
  Future<ApiResponseModel<ResponseModel>> fetchLiveAssets({
    String? orderBy,
    String? orderDirection,
  });
  Future<ApiResponseModel<ResponseModel>> fetchCoinDetails(String time);
  Future<ApiResponseModel<ResponseModel>> getFilteredCoins(
    String orderBy,
    String orderDirection,
  );
}

class CoinsRemoteDatasourceImpl implements CoinsRemoteDatasource {
  final DioApiManager dioApiManager = DioApiManager(baseUrl: Config.apiBaseUrl);
  CoinsRemoteDatasourceImpl();

  @override
  Future<ApiResponseModel<ResponseModel>> fetchLiveAssets({
    String? orderBy,
    String? orderDirection,
  }) async {
    // Çalışan mevcut yapını koruyoruz: Başında hiçbir şey yok, direkt ? ile başlıyor.
    String url = '?referenceCurrencyUuid=5k-_VTxqtCEI';

    // Eğer filtreleme parametreleri geldiyse URL'nin sonuna ekle
    if (orderBy != null && orderDirection != null) {
      url += '&orderBy=$orderBy&orderDirection=$orderDirection';
    }

    final apiResponseModel = await dioApiManager.get<Map<String, dynamic>>(url);

    if (!apiResponseModel.isSuccess || apiResponseModel.data == null) {
      return ApiResponseModel.error(ApiErrorModel(message: 'No data'));
    }

    final responseModel = ResponseModel.fromMap(apiResponseModel.data!);
    return ApiResponseModel.success(responseModel);
  }

  @override
  Future<ApiResponseModel<ResponseModel>> fetchCoinDetails(String time) async {
    final apiResponseModel = await dioApiManager.get<Map<String, dynamic>>(
      '?timePeriod=$time',
    );

    if (!apiResponseModel.isSuccess || apiResponseModel.data == null) {
      return ApiResponseModel.error(ApiErrorModel(message: 'No data'));
    }

    final responseModel = ResponseModel.fromMap(apiResponseModel.data!);
    return ApiResponseModel.success(responseModel);
  }

  @override
  Future<ApiResponseModel<ResponseModel>> getFilteredCoins(
    String orderBy,
    String orderDirection,
  ) async {
    final apiResponseModel = await dioApiManager.get<Map<String, dynamic>>(
      '/coins',
      queryParams: {"orderBy": orderBy, "orderDirection": orderDirection},
    );

    if (!apiResponseModel.isSuccess || apiResponseModel.data == null) {
      return ApiResponseModel.error(ApiErrorModel(message: 'No data'));
    }

    final responseModel = ResponseModel.fromMap(apiResponseModel.data!);
    return ApiResponseModel.success(responseModel);
  }
}
