import 'package:crypto_lens/app/features/data/datasource/local/coin_local_datasource.dart';
import 'package:crypto_lens/app/features/data/datasource/remote/coins_remote_datasource.dart';
import 'package:crypto_lens/app/features/data/repository/coins_repository.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/login/bloc/login_bloc.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_bloc.dart';
import 'package:crypto_lens/core/services/hive/hive_service.dart';
import 'package:get_it/get_it.dart';
import 'package:crypto_lens/app/features/data/datasource/remote/auth_remote_datasource.dart';
import 'package:crypto_lens/app/features/data/repository/auth_repository.dart';
import 'package:crypto_lens/app/features/presentation/register/bloc/register_bloc.dart';

final getIt = GetIt.instance;

final class ServiceLocator {
  static void setup() {
    _setupCore(); // HiveService gibi temel araçlar için
    _setupDataSource();
    _setupRepository();
    _setupBloc();
  }

  /// **Core Tools**
  static void _setupCore() {
    // HiveService'i kaydediyoruz
    getIt.registerLazySingleton<HiveService>(() => HiveService());
  }

  /// **DataSource Dependency**
  static void _setupDataSource() {
    getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(),
    );
    getIt.registerLazySingleton<CoinsRemoteDatasource>(
      () => CoinsRemoteDatasourceImpl(),
    );

    // DÜZELTME: HiveService'i GetIt üzerinden içeri enjekte ediyoruz
    getIt.registerLazySingleton<CoinLocalDatasource>(
      () => CoinLocalDatasourceImpl(getIt<HiveService>()),
    );
  }

  /// **Repository Dependency**
  static void _setupRepository() {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDatasource: getIt<AuthRemoteDatasource>()),
    );

    getIt.registerLazySingleton<CoinsRepository>(
      () => CoinsRepositoryImpl(
        coinsRemoteDatasource: getIt<CoinsRemoteDatasource>(),
        // Değişken isminin CoinsRepositoryImpl içindekiyle aynı olduğuna emin ol (coinLocalDatasource)
        localDatasource: getIt<CoinLocalDatasource>(),
      ),
    );
  }

  /// **BLoC Dependency**
 static void _setupBloc() {
    getIt.registerFactory<RegisterBloc>(
      () => RegisterBloc(getIt<AuthRepository>()),
    );
    getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<AuthRepository>()));
    getIt.registerFactory<MainBloc>(() => MainBloc(getIt<AuthRepository>()));
    getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt<CoinsRepository>()));
    
    // FAVORITES BLOC KAYDI BURAYA:
    getIt.registerFactory<FavoritesBloc>(() => FavoritesBloc(getIt<CoinsRepository>()));
  }
}
