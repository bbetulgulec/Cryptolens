import 'package:crypto_lens/app/features/data/datasource/remote/coins_remote_datasource.dart';
import 'package:crypto_lens/app/features/data/model/response_model.dart';
import 'package:crypto_lens/core/result/result.dart';

abstract class CoinsRepository {
  Future<DataResult<ResponseModel>> fetchLiveAssetsData({bool refresh = false});
  Future<DataResult<ResponseModel>> fetchCoinDetails({required String time});
}

class CoinsRepositoryImpl implements CoinsRepository {
  final CoinsRemoteDatasource coinsRemoteDatasource;

  CoinsRepositoryImpl({required this.coinsRemoteDatasource});

  @override
  Future<DataResult<ResponseModel>> fetchLiveAssetsData({
    bool refresh = false,
  }) async {
    final response = await coinsRemoteDatasource.fetchLiveAssets();

    if (response.isSuccess && response.data != null) {
      return SuccessDataResult(data: response.data!);
    } else {
      return ErrorDataResult(
        message: response.error?.message ?? 'Failed to fetch coins data',
      );
    }
  }

  @override
  Future<DataResult<ResponseModel>> fetchCoinDetails({
    required String time,
  }) async {
    final response = await coinsRemoteDatasource.fetchCoinDetails(time);

    if (response.isSuccess && response.data != null) {
      return SuccessDataResult(data: response.data!);
    } else {
      return ErrorDataResult(
        message: response.error?.message ?? 'Failed to fetch coin details',
      );
    }
  }
}
