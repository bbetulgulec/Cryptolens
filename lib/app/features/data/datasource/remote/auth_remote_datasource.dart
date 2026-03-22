import 'package:crypto_lens/core/dio_manager/api_response_model.dart';
import 'package:crypto_lens/core/logger/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crypto_lens/core/dio_manager/api_error_model.dart'; // Bu importu ekle

abstract class AuthRemoteDatasource {
  Future<ApiResponseModel<AuthResponse>> register(
    String email,
    String password,
  );
  Future<ApiResponseModel<AuthResponse>> login(String email, String password);
  Future<ApiResponseModel<void>> logout();
}

final class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final _supabase = Supabase.instance.client;

  @override
  Future<ApiResponseModel<AuthResponse>> register(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      return ApiResponseModel.success(response);
    } on AuthException catch (e) {
      AppLogger.instance.error("SUPABASE ERROR: ${e.message}");
      return ApiResponseModel.error(ApiErrorModel(message: e.message));
    } catch (e) {
      return ApiResponseModel.error(
        ApiErrorModel(message: "Beklenmedik bir hata oluştu: $e"),
      );
    }
  }

  @override
  Future<ApiResponseModel<AuthResponse>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return ApiResponseModel.success(response);
    } on AuthException catch (e) {
      AppLogger.instance.error("SUPABASE ERROR: ${e.message}");
      return ApiResponseModel.error(ApiErrorModel(message: e.message));
    } catch (e) {
      return ApiResponseModel.error(
        ApiErrorModel(message: "Beklenmedik bir hata oluştu: $e"),
      );
    }
  }

  @override
  Future<ApiResponseModel<void>> logout() async {
    try {
      await _supabase.auth
          .signOut();

      return ApiResponseModel.success(
        null,
      ); 
    } on AuthException catch (e) {
      AppLogger.instance.error("SUPABASE ERROR: ${e.message}");
      return ApiResponseModel.error(ApiErrorModel(message: e.message));
    } catch (e) {
      return ApiResponseModel.error(
        ApiErrorModel(message: "Beklenmedik bir hata oluştu: $e"),
      );
    }
  }
}
