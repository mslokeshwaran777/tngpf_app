//Login Page

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:local_captcha/local_captcha.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngpf/Pages/menu_page.dart';
import 'package:tngpf/api/Suffix_api.dart';
import 'package:tngpf/models/suffix_model.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:tngpf/api/login_api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _localCaptchaController = LocalCaptchaController();
  final TextEditingController gpfnocontroller = TextEditingController();
  final TextEditingController captcha_entry = TextEditingController();
  String Suf = "";
  String GPFNo = "";
  String DOB = " ";
  List<Suffix> suffix_ = [];
  List Activities = ['Activity1', 'Activity2', 'Activity3'];
  Suffix? suf;
  String dropdownvalue = '';
  bool isLoading = false;
  var directory='';
  @override
  void dispose() {
    _localCaptchaController.dispose();
    gpfnocontroller.dispose();
    super.dispose();
  }

  TextEditingController dateInput = TextEditingController();

  static Future<String> getExternalDocumentPath() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }
    final exPath = _directory.path;
    print(_directory.isAbsolute.toString());
    print(exPath);
    return exPath;
  }

  void getDirectory() async {
    directory = await getExternalDocumentPath();
  }

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    initialize();
    getDirectory();
    if(!FlutterDownloader.initialized){
      FlutterDownloader.initialize();
    }
    super.initState();
  }

  void initialize() async {
    await fetchSuffix().then((value) {
      if (value != null) {
        setState(() {
          suffix_ = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: Color(0xFFF5FFFA),
          appBar: AppBar(
            shape: Border(bottom: BorderSide(color: Colors.black, width: 1.5)),
            centerTitle: true,
            elevation: 10.0,
            backgroundColor: Colors.white,
            toolbarHeight: 95.0,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(7.0, 7.0, 10.0, 7.0),
              child: Image.asset(
                './android/images/NationalEmblem.png',
              ),
            ),
            leadingWidth: 70.0,
            titleSpacing: 0.0,
            title: Container(
              width: MediaQuery.of(context).size.width - 150,
              child: Center(
                child: const Text(
                  'ACCOUNTANT GENERAL (A&E), TAMILNADU, CHENNAI',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 7.0, 7.0, 7.0),
                child: Image.asset(
                  './android/images/logo.png',
                  width: 75,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Center(
                        child: Text(
                          'SUBSCRIBER LOGIN',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      //Suffix DropDown
                      Padding(
                        padding: EdgeInsets.fromLTRB(12.0, 40.0, 14.0, 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<dynamic>(
                                  isExpanded: true,
                                  // Initial Value
                                  value: dropdownvalue,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items:
                                      suffix_.map<DropdownMenuItem<dynamic>>((e) {
                                    return DropdownMenuItem(
                                      value: e.msufix,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e.mDeptlst,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) async {
                                    setState(() {
                                      dropdownvalue = newValue;
                                    });
                                    print(dropdownvalue);
                                  },
                                  itemHeight: 57,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //GPF Number TextField
                      Padding(
                        padding: EdgeInsets.fromLTRB(12.0, 20.0, 14.0, 10.0),
                        child: TextField(
                          controller: gpfnocontroller,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.black87),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter GPF Number:',
                            hintStyle: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),

                      //Date of Birth Select Field
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 10.0, 14.0, 10.0),
                        child: Container(
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Date of Birth:',
                              hintStyle: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            controller: dateInput,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(Duration(days: 61 * 365)),
                                  lastDate: DateTime.now());
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);
                                print(formattedDate);
                                setState(() {
                                  dateInput.text = formattedDate;
                                });
                              } else {}
                            },
                          ),
                        ),
                      ),

                      //Captcha Show Field
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 9.0, 14.0, 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Center(
                                  child: LocalCaptcha(
                                    key: const ValueKey(
                                        'to tell widget should update'),
                                    controller: _localCaptchaController,
                                    height: 70,
                                    width: 300,
                                    backgroundColor: Colors.white,
                                    chars: '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                    length: 5,
                                    fontSize: 50.0,
                                    textColors: const [
                                      Colors.black54,
                                      Colors.grey,
                                      Colors.blueGrey,
                                      Colors.redAccent,
                                      Colors.teal,
                                      Colors.amber,
                                      Colors.brown,
                                    ],
                                    noiseColors: [
                                      Colors.green,
                                      Colors.yellow,
                                      Colors.indigo,
                                      Colors.blue,
                                      Colors.red,
                                      Colors.pink,
                                    ],
                                    caseSensitive: true,
                                    codeExpireAfter: const Duration(minutes: 10),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 70.0,
                                  width: 50.0,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          left:
                                              BorderSide(color: Colors.black45))),
                                  child: IconButton(
                                    icon: const Icon(Icons.refresh),
                                    onPressed: () =>
                                        _localCaptchaController.refresh(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Captcha Entry Field
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11.0, 9.0, 13, 10.0),
                        child: TextFormField(
                          controller: captcha_entry,
                          decoration: const InputDecoration(
                              hintText: 'Enter Code',
                              hintStyle: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black87,
                              ),
                              isDense: true,
                              border: OutlineInputBorder()),
                        ),
                      ),

                      //Login Button
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            height: 40.0,
                            width: 120.0,
                            child: ElevatedButton(
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.brown),
                              ),
                              onPressed: () async {
                                if (dropdownvalue == "") {
                                  _localCaptchaController.refresh();
                                  snackBar("Select an valid Suffix");
                                  setState(() {
                                    dropdownvalue = '';
                                    dateInput.clear();
                                    gpfnocontroller.clear();
                                    captcha_entry.clear();
                                    _localCaptchaController.refresh();
                                  });
                                } else if (gpfnocontroller.text == "") {
                                  _localCaptchaController.refresh();
                                  snackBar("GPF Number can't be empty");
                                  setState(() {
                                    dropdownvalue = '';
                                    dateInput.clear();
                                    gpfnocontroller.clear();
                                    captcha_entry.clear();
                                    _localCaptchaController.refresh();
                                  });
                                } else if (dateInput.text == "") {
                                  _localCaptchaController.refresh();
                                  snackBar("Date of Birth can't be empty");
                                  setState(() {
                                    dropdownvalue = '';
                                    dateInput.clear();
                                    gpfnocontroller.clear();
                                    captcha_entry.clear();
                                    _localCaptchaController.refresh();
                                  });
                                } else if (_localCaptchaController
                                        .validate(captcha_entry.text) ==
                                    LocalCaptchaValidation.invalidCode) {
                                  print(_localCaptchaController
                                      .validate(captcha_entry.text));
                                  _localCaptchaController.refresh();
                                  snackBar("Invalid Captcha");
                                  setState(() {
                                    dropdownvalue = '';
                                    dateInput.clear();
                                    gpfnocontroller.clear();
                                    captcha_entry.clear();
                                    _localCaptchaController.refresh();
                                  });
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    String username =
                                        dropdownvalue + gpfnocontroller.text;
                                    var firstEncr = await encrypt(
                                        username, 'agsEncryptionKey');
                                    firstEncr = firstEncr.replaceAll('"', '');
                                    print('firstenct $firstEncr');
                                    final response_token =
                                        await responseTokenGen(firstEncr);
                                    print('response_token : $response_token');
                                    var password = await ecryptPassword(
                                        dateInput.text, response_token);
                                    password = password.replaceAll('"', '');
                                    print('password : $password');
                                    final authen_msg = await authenticate(
                                        firstEncr,
                                        password,
                                        response_token,
                                        dropdownvalue);
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setBool('isLoggedIn', true);
                                    prefs.setString('name', authen_msg[0]);
                                    prefs.setString('suffix', dropdownvalue);
                                    prefs.setString('GPFNumber', gpfnocontroller.text);
                                    prefs.setString('designation', authen_msg[1]);
                                    prefs.setString('userName', firstEncr);
                                    prefs.setString('password', password);
                                    prefs.setString('response_token', response_token);
                                    prefs.setString('directory', directory);
                                    print(prefs);
                                    print('auth_msg : $authen_msg');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Menu(
                                                  key: widget.key,
                                                  name: authen_msg[0],
                                                  suffix: dropdownvalue,
                                                  GPFNumber: gpfnocontroller.text,
                                                  designation: authen_msg[1],
                                                  userName: firstEncr,
                                                  password: password,
                                                  response_token: response_token, directory: directory,
                                                )));
                                  } catch (e) {
                                    print(e);
                                    snackBar("Invalid Credentials Try Again");
                                    setState(() {
                                      dropdownvalue = '';
                                      dateInput.clear();
                                      gpfnocontroller.clear();
                                      captcha_entry.clear();
                                      _localCaptchaController.refresh();
                                    });
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffFEEED5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (isLoading)
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onWillPop: () {
          return Exit() ?? false;
        },
      ),
    );
  }

  snackBar(String Message) {
    final snackbar = SnackBar(
      content: Text(Message),
      duration: const Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}


Exit() {
  exit(0);
}
