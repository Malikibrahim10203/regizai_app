import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:regizai/dashboard.dart';
import 'package:regizai/login.dart';
import 'signup.dart';
import 'gender_page.dart';
import 'biodata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
