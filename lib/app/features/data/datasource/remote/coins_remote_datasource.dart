import 'package:crypto_lens/app/common/config/config.dart';
import 'package:crypto_lens/app/features/data/model/response_model.dart';
import 'package:crypto_lens/core/dio_manager/api_error_model.dart';
import 'package:crypto_lens/core/dio_manager/api_response_model.dart';
import 'package:crypto_lens/core/dio_manager/dio_manager.dart';

abstract class CoinsRemoteDatasource {
  Future<ApiResponseModel<ResponseModel>> fetchLiveAssets();
  Future<ApiResponseModel<ResponseModel>> fetchCoinDetails(String time);
}

class CoinsRemoteDatasourceImpl implements CoinsRemoteDatasource {
  final DioApiManager dioApiManager = DioApiManager(baseUrl: Config.apiBaseUrl);
  CoinsRemoteDatasourceImpl();

  @override
  Future<ApiResponseModel<ResponseModel>> fetchLiveAssets() async {
    final apiResponseModel = await dioApiManager.get<Map<String, dynamic>>(
      '?referenceCurrencyUuid=5k-_VTxqtCEI',
    );
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
}
