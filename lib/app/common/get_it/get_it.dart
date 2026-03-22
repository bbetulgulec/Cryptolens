/*

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// **Service provider class managing all dependencies**
final class ServiceLocator {
  /// **Main method to call to set up dependencies**
  void setup() {
    _setupRouter();
    _setupDataSource();
    _setupRepository();
    _setupCubit();
  }

  /// **Router Dependency**
  void _setupRouter() {
    // getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  }

  /// **DataSource Dependency**
  void _setupDataSource() {
    getIt
      ..registerLazySingleton<TestRemoteDatasource>(
        TestRemoteDatasourceImpl.new,
      );
    
  }

  /// **Repository Dependency**
  void _setupRepository() {
    getIt
      ..registerLazySingleton<TestRepository>(
        () => TestRepositoryImpl(
          remoteDatasource: getIt<TestRemoteDatasource>(),
          localDatasource: getIt<TestLocalDatasource>(),
        ),
      );
   
  }

  /// **BLoC, Cubit and ViewModel Dependency**
  void _setupCubit() {
    getIt
      ..registerLazySingleton<OnboardingCubit>(OnboardingCubit.new)
      ..registerLazySingleton<MainCubit>(
        () => MainCubit(testRepository: getIt<TestRepository>()),
      );
      
  }

  Future<void> reset() async {
    await getIt.reset();
    setup();
  }
}

*/
