import 'package:crypto_lens/app/features/data/datasource/local/coin_local_datasource.dart';
import 'package:crypto_lens/app/features/data/datasource/remote/coins_remote_datasource.dart';
import 'package:crypto_lens/app/features/data/model/response_model.dart';
import 'package:crypto_lens/core/result/result.dart';

abstract class CoinsRepository {
  Future<DataResult<ResponseModel>> fetchLiveAssetsData({
    bool refresh = false,
    String? orderBy,
    String? orderDirection,
  });
  Future<DataResult<ResponseModel>> fetchCoinDetails({
    required String time,
    String? uuid,
  });
  Future<DataResult<ResponseModel>> getFilteredCoins({
    required String orderBy,
    required String orderDirection,
  });
  List<String> getFavorites();
  Future<void> toggleFavorite(String uuid);
}

class CoinsRepositoryImpl implements CoinsRepository {
  final CoinsRemoteDatasource coinsRemoteDatasource;
  final CoinLocalDatasource localDatasource;

  ResponseModel? _cachedResponse;
  final Map<String, ResponseModel> _detailsCache = {};

  CoinsRepositoryImpl({
    required this.coinsRemoteDatasource,
    required this.localDatasource,
  });

  // CoinsRepositoryImpl içinde
  @override
  Future<DataResult<ResponseModel>> fetchLiveAssetsData({
    bool refresh = false,
    String? orderBy,
    String? orderDirection,
  }) async {
    if (!refresh && _cachedResponse != null && orderBy == null) {
      return SuccessDataResult(data: _cachedResponse!);
    }

    final response = await coinsRemoteDatasource.fetchLiveAssets(
      orderBy: orderBy,
      orderDirection: orderDirection,
    );

    if (response.isSuccess && response.data != null) {
      return SuccessDataResult(data: response.data!);
    } else {
      if (_cachedResponse != null) {
        return SuccessDataResult(data: _cachedResponse!);
      }
      return ErrorDataResult(
        message: response.error?.message ?? 'Failed to fetch coins data',
      );
    }
  }

  @override
  Future<DataResult<ResponseModel>> fetchCoinDetails({
    required String time,
    String? uuid,
  }) async {
    final String cacheKey = "${uuid}_$time";
    if (_detailsCache.containsKey(cacheKey)) {
      return SuccessDataResult(data: _detailsCache[cacheKey]!);
    }

    final response = await coinsRemoteDatasource.fetchCoinDetails(time);

    if (response.isSuccess && response.data != null) {
      _detailsCache[cacheKey] = response.data!;
      return SuccessDataResult(data: response.data!);
    } else {
      return ErrorDataResult(
        message: response.error?.message ?? 'Failed to fetch coin details',
      );
    }
  }

  @override
  Future<DataResult<ResponseModel>> getFilteredCoins({
    required String orderBy,
    required String orderDirection,
  }) async {
    final response = await coinsRemoteDatasource.getFilteredCoins(
      orderBy,
      orderDirection,
    );

    if (response.isSuccess && response.data != null) {
      return SuccessDataResult(data: response.data!);
    } else {
      return ErrorDataResult(
        message: response.error?.message ?? 'Failed to fetch coins data',
      );
    }
  }

  @override
  List<String> getFavorites() {
    return localDatasource.getFavoriteUuids();
  }

  @override
  Future<void> toggleFavorite(String uuid) async {
    await localDatasource.toggleFavorite(uuid);
  }
}
