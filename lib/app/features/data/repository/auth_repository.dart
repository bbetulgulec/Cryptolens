import 'package:crypto_lens/app/features/data/datasource/remote/auth_remote_datasource.dart';
import 'package:crypto_lens/core/logger/app_logger.dart';
import 'package:crypto_lens/core/result/result.dart';

abstract class AuthRepository {
  Future<DataResult<bool>> register(String email, String password);
  Future<DataResult<bool>> login(String email, String password);
  Future<DataResult<bool>> logout();
}

final class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;

  AuthRepositoryImpl({required AuthRemoteDatasource remoteDatasource})
    : _remoteDatasource = remoteDatasource;

  @override
  Future<DataResult<bool>> register(String email, String password) async {
    final result = await _remoteDatasource.register(email, password);

    if (result.isSuccess) {
      AppLogger.instance.log("succesfful register");
      return SuccessDataResult(data: true);
    } else {
      return ErrorDataResult(
        message: result.error?.message ?? "Kayıt işlemi başarısız.",
      );
    }
  }

  @override
  Future<DataResult<bool>> login(String email, String password) async {
    final result = await _remoteDatasource.login(email, password);

    if (result.isSuccess) {
      AppLogger.instance.log("succesful login");
      return SuccessDataResult(data: true);
    } else {
      return ErrorDataResult(
        message: result.error?.message ?? "Kayıt işlemi başarısız.",
      );
    }
  }

  @override
  Future<DataResult<bool>> logout() async {
    final result = await _remoteDatasource.logout();

    if (result.isSuccess) {
      AppLogger.instance.log("succesful logout");
      return SuccessDataResult(data: true);
    } else {
      return ErrorDataResult(
        message: result.error?.message ?? "Çıkış işlemi başarısız.",
      );
    }
  }
}
