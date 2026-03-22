import 'package:crypto_lens/app/features/data/datasource/remote/coins_remote_datasource.dart';
import 'package:crypto_lens/app/features/data/repository/coins_repository.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/login/bloc/login_bloc.dart';
import 'package:crypto_lens/app/features/presentation/main/bloc/main_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:crypto_lens/app/features/data/datasource/remote/auth_remote_datasource.dart';
import 'package:crypto_lens/app/features/data/repository/auth_repository.dart';
import 'package:crypto_lens/app/features/presentation/register/bloc/register_bloc.dart';

final getIt = GetIt.instance;

final class ServiceLocator {
  static void setup() {
    _setupDataSource();
    _setupRepository();
    _setupBloc();
  }

  /// **DataSource Dependency**
  static void _setupDataSource() {
    // Supabase kullanan Remote Datasource
    getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(),
    );
    getIt.registerLazySingleton<CoinsRemoteDatasource>(
      () => CoinsRemoteDatasourceImpl(),
    );
  }

  /// **Repository Dependency**
  static void _setupRepository() {
    // Datasource'u GetIt içinden çekerek Repository'ye veriyoruz
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDatasource: getIt<AuthRemoteDatasource>()),
    );
    getIt.registerLazySingleton<CoinsRepository>(
      () => CoinsRepositoryImpl(
        coinsRemoteDatasource: getIt<CoinsRemoteDatasource>(),
      ),
    );
  }

  /// **BLoC Dependency**
  static void _setupBloc() {
    // RegisterBloc her ihtiyaç duyulduğunda yeni bir instance oluşturması için
    // registerFactory kullanmak BLoC'lar için daha sağlıklıdır (sayfa kapanınca temizlenir).
    getIt.registerFactory<RegisterBloc>(
      () => RegisterBloc(getIt<AuthRepository>()),
    );
    getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<AuthRepository>()));
    getIt.registerFactory<MainBloc>(() => MainBloc(getIt<AuthRepository>()));
    getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt<CoinsRepository>()));
  }
}
