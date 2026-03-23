import 'package:crypto_lens/core/services/hive/dialog_service.dart';
import 'package:dio/dio.dart';

class RateLimitInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 429 Rate Limit hatası mı kontrol et
    if (err.response?.statusCode == 429) {
      // API genellikle 'Retry-After' header'ı ile kaç saniye beklemen gerektiğini söyler
      // Eğer gelmiyorsa varsayılan 10 saniye diyelim
      final retryAfter =
          int.tryParse(err.response?.headers.value('retry-after') ?? '') ?? 10;

      // Diyaloğu aç
      DialogService.showRateLimitDialog(retryAfter);

      // Belirlenen süre kadar bekle ve diyaloğu kapat
      await Future.delayed(Duration(seconds: retryAfter));
      DialogService.closeDialog();

      // Not: İstersen burada isteği tekrar gönderebilirsin (Retry logic)
    }

    // Hatayı zincirde devam ettir
    return handler.next(err);
  }
}
