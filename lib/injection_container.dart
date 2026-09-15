import 'package:shared_preferences/shared_preferences.dart';
import 'package:regizai/features/articles/domain/usecases/get_articles_usecase.dart';
import 'package:regizai/features/articles/presentation/cubit/article_cubit.dart';
import 'package:regizai/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:regizai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:regizai/features/auth/domain/repositories/auth_repository.dart';
import 'package:regizai/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/login_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/logout_usecase.dart';
import 'package:regizai/features/auth/domain/usecases/signup_usecase.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/bmi/domain/usecases/calculate_bmi_usecase.dart';
import 'package:regizai/features/bmi/presentation/cubit/bmi_cubit.dart';
import 'package:regizai/features/food_catalog/data/datasources/food_mock_datasource.dart';
import 'package:regizai/features/food_catalog/data/repositories/food_repository_impl.dart';
import 'package:regizai/features/food_catalog/domain/repositories/food_repository.dart';
import 'package:regizai/features/food_catalog/domain/usecases/get_foods_usecase.dart';
import 'package:regizai/features/food_catalog/presentation/cubit/food_catalog_cubit.dart';
import 'package:regizai/features/ai_scanner/data/datasources/scanner_mock_datasource.dart';
import 'package:regizai/features/ai_scanner/data/repositories/scanner_repository_impl.dart';
import 'package:regizai/features/ai_scanner/domain/repositories/scanner_repository.dart';
import 'package:regizai/features/ai_scanner/domain/usecases/scan_food_usecase.dart';
import 'package:regizai/features/ai_scanner/presentation/bloc/scanner_bloc.dart';
import 'package:regizai/features/journal/data/datasources/journal_local_datasource.dart';
import 'package:regizai/features/journal/data/repositories/journal_repository_impl.dart';
import 'package:regizai/features/journal/domain/repositories/journal_repository.dart';
import 'package:regizai/features/journal/domain/usecases/journal_usecases.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  late SharedPreferences sharedPreferences;

  // Repositories
  late AuthRepository authRepository;
  late JournalRepository journalRepository;
  late FoodRepository foodRepository;
  late ScannerRepository scannerRepository;

  // UseCases
  late LoginUseCase loginUseCase;
  late SignUpUseCase signUpUseCase;
  late ForgotPasswordUseCase forgotPasswordUseCase;
  late GetCurrentUserUseCase getCurrentUserUseCase;
  late LogoutUseCase logoutUseCase;
  late EditProfileUseCase editProfileUseCase;

  late GetJournalLogsUseCase getJournalLogsUseCase;
  late AddJournalLogUseCase addJournalLogUseCase;
  late DeleteJournalLogUseCase deleteJournalLogUseCase;
  late GetTodayCaloriesUseCase getTodayCaloriesUseCase;

  late GetFoodsUseCase getFoodsUseCase;
  late ScanFoodUseCase scanFoodUseCase;
  late CalculateBmiUseCase calculateBmiUseCase;
  late GetArticlesUseCase getArticlesUseCase;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();

    // DataSources
    final authLocalDataSource = AuthLocalDataSourceImpl(sharedPreferences);
    final journalLocalDataSource = JournalLocalDataSourceImpl(sharedPreferences);
    final foodMockDataSource = FoodMockDataSourceImpl();
    final scannerMockDataSource = ScannerMockDataSourceImpl();

    // Repositories
    authRepository = AuthRepositoryImpl(authLocalDataSource);
    journalRepository = JournalRepositoryImpl(journalLocalDataSource);
    foodRepository = FoodRepositoryImpl(foodMockDataSource);
    scannerRepository = ScannerRepositoryImpl(scannerMockDataSource);

    // UseCases
    loginUseCase = LoginUseCase(authRepository);
    signUpUseCase = SignUpUseCase(authRepository);
    forgotPasswordUseCase = ForgotPasswordUseCase(authRepository);
    getCurrentUserUseCase = GetCurrentUserUseCase(authRepository);
    logoutUseCase = LogoutUseCase(authRepository);
    editProfileUseCase = EditProfileUseCase(authRepository);

    getJournalLogsUseCase = GetJournalLogsUseCase(journalRepository);
    addJournalLogUseCase = AddJournalLogUseCase(journalRepository);
    deleteJournalLogUseCase = DeleteJournalLogUseCase(journalRepository);
    getTodayCaloriesUseCase = GetTodayCaloriesUseCase(journalRepository);

    getFoodsUseCase = GetFoodsUseCase(foodRepository);
    scanFoodUseCase = ScanFoodUseCase(scannerRepository);
    calculateBmiUseCase = CalculateBmiUseCase();
    getArticlesUseCase = GetArticlesUseCase();
  }

  // Bloc & Cubit Factories
  AuthBloc createAuthBloc() => AuthBloc(
        loginUseCase: loginUseCase,
        signUpUseCase: signUpUseCase,
        forgotPasswordUseCase: forgotPasswordUseCase,
        getCurrentUserUseCase: getCurrentUserUseCase,
        logoutUseCase: logoutUseCase,
        editProfileUseCase: editProfileUseCase,
      );

  JournalBloc createJournalBloc() => JournalBloc(
        getLogsUseCase: getJournalLogsUseCase,
        addLogUseCase: addJournalLogUseCase,
        deleteLogUseCase: deleteJournalLogUseCase,
        getTodayCaloriesUseCase: getTodayCaloriesUseCase,
      );

  FoodCatalogCubit createFoodCatalogCubit() => FoodCatalogCubit(getFoodsUseCase);
  ScannerBloc createScannerBloc() => ScannerBloc(scanFoodUseCase);
  BmiCubit createBmiCubit() => BmiCubit(calculateBmiUseCase);
  ArticleCubit createArticleCubit() => ArticleCubit(getArticlesUseCase);
}

final sl = ServiceLocator();
