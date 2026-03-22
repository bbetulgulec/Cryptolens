import 'package:crypto_lens/core/services/hive/hive_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CoinLocalDatasource {
  // 1. BURAYA email EKLEDİK
  List<String> getFavoriteUuids();

  Future<void> toggleFavorite(String uuid);
}

class CoinLocalDatasourceImpl implements CoinLocalDatasource {
  final HiveService _hiveService;
  // Supabase'i buraya taşıdık
  final _supabase = Supabase.instance.client;

  CoinLocalDatasourceImpl(this._hiveService);

  // Yardımcı metod: O anki kullanıcının emailini güvenli bir key'e dönüştürür
  String get _userKey => _supabase.auth.currentUser?.email ?? 'guest_user';

  @override
  List<String> getFavoriteUuids() {
    // Artık dışarıdan email beklemiyoruz, içeride kendisi buluyor
    final data = _hiveService.get<List<dynamic>>(_userKey);
    return data?.cast<String>() ?? [];
  }

  @override
  Future<void> toggleFavorite(String uuid) async {
    final favorites = getFavoriteUuids();

    if (favorites.contains(uuid)) {
      favorites.remove(uuid);
    } else {
      favorites.add(uuid);
    }
    // Kullanıcının emailini anahtar (key) olarak kullanıp kaydediyoruz
    await _hiveService.put(_userKey, favorites);
  }
}
