import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:qpc/app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DartVLC.initialize();
  runApp(
    GetMaterialApp(
      title: "QPC",
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.noTransition,
      getPages: AppPages.routes,
      theme: ThemeData(
        primaryColor: Colors.yellow,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
      ),
    ),
  );
}
