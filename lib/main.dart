import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tngpf/Pages/splash_screen.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async{
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,

    ),

  );
}