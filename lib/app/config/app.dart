import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regizai/app/config/routes/app_routes.dart';
import 'package:regizai/core/theme/app_theme.dart';
import 'package:regizai/core/di/injection_container.dart' as di;
import 'package:regizai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:regizai/features/auth/presentation/bloc/auth_event.dart';
import 'package:regizai/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:regizai/features/food_catalog/presentation/cubit/food_catalog_cubit.dart';
import 'package:regizai/features/ai_scanner/presentation/bloc/scanner_bloc.dart';
import 'package:regizai/features/bmi/presentation/cubit/bmi_cubit.dart';
import 'package:regizai/features/articles/presentation/cubit/article_cubit.dart';

class RegizAiApp extends StatelessWidget {
  const RegizAiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()..add(CheckAuthStatusEvent()),
        ),
        BlocProvider<JournalBloc>(
          create: (_) => di.sl<JournalBloc>()..add(const LoadJournalEvent('user_01')),
        ),
        BlocProvider<FoodCatalogCubit>(
          create: (_) => di.sl<FoodCatalogCubit>()..loadFoods(),
        ),
        BlocProvider<ScannerBloc>(
          create: (_) => di.sl<ScannerBloc>(),
        ),
        BlocProvider<BmiCubit>(
          create: (_) => di.sl<BmiCubit>(),
        ),
        BlocProvider<ArticleCubit>(
          create: (_) => di.sl<ArticleCubit>()..loadArticles(),
        ),
      ],
      child: MaterialApp(
        title: 'RegizAI - Smart Nutrition App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.initial,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
