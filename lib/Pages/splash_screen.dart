import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menu_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasConnection = false;
  bool isLoading = false;
  String? roles;
  late String name;
  late String suffix;
  late String GPFNumber;
  late String designation;
  late String userName;
  late String password;
  late String response_token;
  late String directory;
  bool isLoggedIn=false;
  bool _isDialogShown = false;


  @override
  void initState() {
    super.initState();
    fetchLoginParameters();
    checkAuthentication();
  }



  Future<void> fetchLoginParameters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    suffix = prefs.getString('suffix') ?? '';
    GPFNumber = prefs.getString('GPFNumber') ?? '';
    designation = prefs.getString('designation') ?? '';
    userName = prefs.getString('userName') ?? '';
    password = prefs.getString('password') ?? '';
    response_token = prefs.getString('response_token') ?? '';
    directory = prefs.getString('directory') ?? '';
  }

  Future<void> checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('isLoggedIn')==null?isLoggedIn=false:isLoggedIn=prefs.getBool('isLoggedIn')!;
    print(prefs);
    Timer(const Duration(seconds: 3), () => isLoggedIn?Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu(name: name, suffix: suffix, GPFNumber: GPFNumber, designation: designation, userName: userName, password: password, response_token: response_token, directory: directory))):Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff98ede5),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFF5FFFA),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "./android/images/splash_logo.png",
                height: 180,
                width: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 15,),
              Text("TNGPF",style: TextStyle(fontSize: 25,color: Colors.blue.shade800),),
              const SizedBox(height: 15,),
              Text("(Tamil Nadu General Provident Fund)",style: TextStyle(fontSize: 12,color: Colors.blue.shade800),),
              const SizedBox(height: 30,),
              //change versionName here
              Text("Version: 1.0",style: TextStyle(fontSize: 25,color: Colors.blue.shade800),)
            ],
          ),
        ),
      ),
    );
  }
}