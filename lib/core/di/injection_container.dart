import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Auth
import 'package:regizai/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:regizai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:regizai/features/auth/domain/repositories/auth_repository.dart';
import 'package:regizai/features/auth/domain/usecases/login_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/signup_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/logout_usecase.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';

// Journal
import 'package:regizai/features/journal/data/datasources/journal_local_datasource.dart';
import 'package:regizai/features/journal/data/repositories/journal_repository_impl.dart';
import 'package:regizai/features/journal/domain/repositories/journal_repository.dart';
import 'package:regizai/features/journal/domain/usecases/journal_usecases.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';

// Food Catalog
import 'package:regizai/features/food_catalog/data/datasources/food_mock_datasource.dart';
import 'package:regizai/features/food_catalog/data/datasources/fatsecret_remote_datasource.dart';
import 'package:regizai/features/food_catalog/data/repositories/food_repository_impl.dart';
import 'package:regizai/features/food_catalog/domain/repositories/food_repository.dart';
import 'package:regizai/features/food_catalog/domain/usecases/get_foods_usecase.dart';
import 'package:regizai/features/food_catalog/presentation/cubit/food_catalog_cubit.dart';

// AI Scanner
import 'package:regizai/features/ai_scanner/data/datasources/scanner_mock_datasource.dart';
import 'package:regizai/features/ai_scanner/data/repositories/scanner_repository_impl.dart';
import 'package:regizai/features/ai_scanner/domain/repositories/scanner_repository.dart';
import 'package:regizai/features/ai_scanner/domain/usecases/scan_food_usecase.dart';
import 'package:regizai/features/ai_scanner/presentation/bloc/scanner_bloc.dart';

// BMI
import 'package:regizai/features/bmi/domain/usecases/calculate_bmi_usecase.dart';
import 'package:regizai/features/bmi/presentation/cubit/bmi_cubit.dart';

// Articles
import 'package:regizai/features/articles/domain/usecases/get_articles_usecase.dart';
import 'package:regizai/features/articles/presentation/cubit/article_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }

  //! Auth Feature
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => EditProfileUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      signUpUseCase: sl(),
      editProfileUseCase: sl(),
      forgotPasswordUseCase: sl(),
      getCurrentUserUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  //! Journal Feature
  sl.registerLazySingleton<JournalLocalDataSource>(
    () => JournalLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<JournalRepository>(
    () => JournalRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetJournalLogsUseCase(sl()));
  sl.registerLazySingleton(() => AddJournalLogUseCase(sl()));
  sl.registerLazySingleton(() => DeleteJournalLogUseCase(sl()));
  sl.registerLazySingleton(() => GetTodayCaloriesUseCase(sl()));
  sl.registerFactory(
    () => JournalBloc(
      getLogsUseCase: sl(),
      addLogUseCase: sl(),
      deleteLogUseCase: sl(),
      getTodayCaloriesUseCase: sl(),
    ),
  );

  //! Food Catalog Feature
  sl.registerLazySingleton<FoodMockDataSource>(() => FoodMockDataSourceImpl());
  sl.registerLazySingleton<FatSecretRemoteDataSource>(
    () => FatSecretRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<FoodRepository>(
    () => FoodRepositoryImpl(
      mockDataSource: sl(),
      fatSecretDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetFoodsUseCase(sl()));
  sl.registerFactory(() => FoodCatalogCubit(sl()));

  //! AI Scanner Feature
  sl.registerLazySingleton<ScannerMockDataSource>(() => ScannerMockDataSourceImpl());
  sl.registerLazySingleton<ScannerRepository>(
    () => ScannerRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => ScanFoodUseCase(sl()));
  sl.registerFactory(() => ScannerBloc(sl()));

  //! BMI Feature
  sl.registerLazySingleton(() => CalculateBmiUseCase());
  sl.registerFactory(() => BmiCubit(sl()));

  //! Articles Feature
  sl.registerLazySingleton(() => GetArticlesUseCase());
  sl.registerFactory(() => ArticleCubit(sl()));
}
