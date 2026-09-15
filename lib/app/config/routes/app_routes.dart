import 'package:flutter/material.dart';
import 'package:regizai/features/auth/presentation/pages/login_page.dart';
import 'package:regizai/features/auth/presentation/pages/signup_page.dart';
import 'package:regizai/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:regizai/features/auth/presentation/pages/biodata_page.dart';
import 'package:regizai/features/auth/presentation/pages/gender_page.dart';
import 'package:regizai/features/auth/presentation/pages/profile_page.dart';
import 'package:regizai/features/auth/presentation/pages/edit_profile_page.dart';
import 'package:regizai/features/journal/presentation/pages/dashboard_page.dart';
import 'package:regizai/features/journal/presentation/pages/journal_page.dart';
import 'package:regizai/features/food_catalog/presentation/pages/food_catalog_page.dart';
import 'package:regizai/features/food_catalog/presentation/pages/food_detail_page.dart';
import 'package:regizai/features/ai_scanner/presentation/pages/camera_scanner_page.dart';
import 'package:regizai/features/ai_scanner/presentation/pages/scan_preview_page.dart';
import 'package:regizai/features/bmi/presentation/pages/bmi_calculator_page.dart';
import 'package:regizai/features/bmi/presentation/pages/bmi_result_page.dart';
import 'package:regizai/features/articles/domain/entities/article_entity.dart';
import 'package:regizai/features/articles/presentation/pages/articles_page.dart';
import 'package:regizai/features/articles/presentation/pages/article_detail_page.dart';

class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String biodata = '/biodata';
  static const String gender = '/gender';
  static const String dashboard = '/dashboard';
  static const String journal = '/journal';
  static const String foodCatalog = '/food-catalog';
  static const String foodDetail = '/food-detail';
  static const String cameraScanner = '/camera-scanner';
  static const String scanPreview = '/scan-preview';
  static const String bmiCalculator = '/bmi-calculator';
  static const String bmiResult = '/bmi-result';
  static const String articles = '/articles';
  static const String articleDetail = '/article-detail';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case biodata:
        return MaterialPageRoute(builder: (_) => const BiodataPage());
      case gender:
        return MaterialPageRoute(builder: (_) => const GenderPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case journal:
        return MaterialPageRoute(builder: (_) => const JournalPage());
      case foodCatalog:
        return MaterialPageRoute(builder: (_) => const FoodCatalogPage());
      case foodDetail:
        final food = settings.arguments;
        return MaterialPageRoute(builder: (_) => FoodDetailPage(food: food));
      case cameraScanner:
        return MaterialPageRoute(builder: (_) => const CameraScannerPage());
      case scanPreview:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ScanPreviewPage(
            imagePath: args?['imagePath'] ?? '',
            foodName: args?['foodName'] ?? 'Nasi Goreng Sehat',
            calories: args?['calories'] ?? 350.0,
            protein: args?['protein'] ?? 15.0,
            fat: args?['fat'] ?? 10.0,
            carbs: args?['carbs'] ?? 45.0,
          ),
        );
      case bmiCalculator:
        return MaterialPageRoute(builder: (_) => const BmiCalculatorPage());
      case bmiResult:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => BmiResultPage(
            bmi: args?['bmi'] ?? 22.0,
            category: args?['category'] ?? 'Normal',
            recommendation: args?['recommendation'] ?? 'Berat badan ideal.',
          ),
        );
      case articles:
        return MaterialPageRoute(builder: (_) => const ArticlesPage());
      case articleDetail:
        final article = settings.arguments as ArticleEntity?;
        if (article != null) {
          return MaterialPageRoute(builder: (_) => ArticleDetailPage(article: article));
        }
        return MaterialPageRoute(builder: (_) => const ArticlesPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Halaman tidak ditemukan: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
