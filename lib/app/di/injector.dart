// ignore_for_file: cascade_invocations, document_ignores
import 'package:flutter_clean_architecture_cubit_guide/app/config/build_config.dart';
import 'package:flutter_clean_architecture_cubit_guide/app/config/env.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/network/http_client.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/storage/key_value_store.dart';
import 'package:flutter_clean_architecture_cubit_guide/core/storage/secure_storage.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/presentation/state/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global service locator
final GetIt getIt = GetIt.instance;

/// Dependency injection setup
class Injector {
  /// Initialize all dependencies
  static Future<void> init() async {
    // Core dependencies
    await _initCore();

    // Data sources
    _initDataSources();

    // Repositories
    _initRepositories();

    // Use cases
    _initUseCases();

    // Cubits
    _initCubits();
  }

  /// Initialize core dependencies
  static Future<void> _initCore() async {
    // SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);

    // KeyValueStore
    getIt.registerLazySingleton<KeyValueStore>(
      () => KeyValueStoreImpl(sharedPreferences),
    );

    // SecureStorage
    getIt.registerLazySingleton<SecureStorage>(
      () => const SecureStorageImpl(),
    );

    // Interceptors
    getIt.registerLazySingleton<LoggingInterceptor>(
      () => LoggingInterceptor(
        enableLogging: BuildConfig.enableInterceptorLogging,
      ),
    );

    getIt.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(getIt<SecureStorage>()),
    );

    // HTTP Client
    getIt.registerLazySingleton<HttpClient>(
      () => HttpClientImpl(
        baseUrl: Env.fullApiUrl,
        connectTimeout: Env.connectionTimeoutDuration,
        receiveTimeout: Env.receiveTimeoutDuration,
        sendTimeout: Env.sendTimeoutDuration,
        authInterceptor: getIt<AuthInterceptor>(),
        loggingInterceptor: getIt<LoggingInterceptor>(),
      ),
    );
  }

  /// Initialize data sources
  static void _initDataSources() {
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt<HttpClient>()),
    );

    getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        getIt<SecureStorage>(),
        getIt<KeyValueStore>(),
      ),
    );
  }

  /// Initialize repositories
  static void _initRepositories() {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        getIt<AuthRemoteDataSource>(),
        getIt<AuthLocalDataSource>(),
      ),
    );
  }

  /// Initialize use cases
  static void _initUseCases() {
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<RefreshTokenUseCase>(
      () => RefreshTokenUseCase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<IsLoggedInUseCase>(
      () => IsLoggedInUseCase(getIt<AuthRepository>()),
    );
  }

  /// Initialize cubits
  static void _initCubits() {
    getIt.registerFactory<AuthCubit>(
      () => AuthCubit(
        loginUseCase: getIt<LoginUseCase>(),
        registerUseCase: getIt<RegisterUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
        refreshTokenUseCase: getIt<RefreshTokenUseCase>(),
        getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
        isLoggedInUseCase: getIt<IsLoggedInUseCase>(),
      ),
    );
  }

  /// Reset all dependencies (useful for testing)
  static void reset() {
    getIt.reset();
  }
}
