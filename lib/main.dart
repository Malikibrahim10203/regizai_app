import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/features/articles/presentation/cubit/article_cubit.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_state.dart';
import 'package:regizai/features/bmi/presentation/cubit/bmi_cubit.dart';
import 'package:regizai/features/food_catalog/presentation/cubit/food_catalog_cubit.dart';
import 'package:regizai/features/ai_scanner/presentation/bloc/scanner_bloc.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';
// import removed
import 'package:regizai/injection_container.dart';
import 'package:regizai/login.dart';
import 'package:regizai/pages/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl.createAuthBloc()..add(CheckAuthStatusEvent()),
        ),
        BlocProvider<JournalBloc>(
          create: (_) => sl.createJournalBloc(),
        ),
        BlocProvider<FoodCatalogCubit>(
          create: (_) => sl.createFoodCatalogCubit()..loadFoods(),
        ),
        BlocProvider<BmiCubit>(
          create: (_) => sl.createBmiCubit(),
        ),
        BlocProvider<ArticleCubit>(
          create: (_) => sl.createArticleCubit()..loadArticles(),
        ),
        BlocProvider<ScannerBloc>(
          create: (_) => sl.createScannerBloc(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Regizai',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              // Trigger initial journal load for user
              context.read<JournalBloc>().add(LoadJournalEvent(state.user.id));
              return const Dashboard();
            }
            return const Login();
          },
        ),
      ),
    );
  }
}
