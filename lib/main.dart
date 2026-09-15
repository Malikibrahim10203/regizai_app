import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:regizai/pages/dashboard.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/login.dart';
import 'package:regizai/model/user.dart';
import 'signup.dart';


import 'package:regizai/theme/app_theme.dart';
import 'package:regizai/mock/offline_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OfflineService.initSeedData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Regizai',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: FutureBuilder(
        future: EventPref.getUser(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          return snapshot.data == null ? Login() : const Dashboard();
        },
      ),
    );
  }
}
