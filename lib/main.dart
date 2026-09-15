import 'package:flutter/material.dart';
import 'package:regizai/app/config/app.dart';
import 'package:regizai/app/config/app_config.dart';
import 'package:regizai/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Environment & Global Config
  AppConfig.init(
    environment: Environment.dev,
    appTitle: 'RegizAI',
    isOfflineMock: true,
  );

  // Inisialisasi Dependency Injection (GetIt)
  await di.init();

  // Jalankan Aplikasi
  runApp(const RegizAiApp());
}
