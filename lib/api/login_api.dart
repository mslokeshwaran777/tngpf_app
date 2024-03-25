import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import 'package:xml/xml.dart';

//Encryption Methods

//Step:1 Encrypt

Future<String> encrypt(userName, token) async {
  final url = 'https://agae.tn.nic.in/OnlineGPF_API/Login/Encrypt';
  http.Response response = await http.post(Uri.parse(url), body: {
    'KeyMain': token,
    'value': userName, //
  });
  final value1 = response.body;
  return value1.toString();
}

//Step:2 response_token_generation

Future<String> responseTokenGen(userName) async {
  final url = 'https://agae.tn.nic.in/OnlineGPF_API/Login/response_token_gen';
  http.Response response = await http.post(Uri.parse(url), body: {
    'token': "agsEncryptionKey",
    'imei_no': "000000000000000",
    'gpfno': userName,
  });
  final value2 = response.body;
  print('value2 : $value2');
  XmlDocument document = XmlDocument.parse(value2);
  var responseTokenElement = document.findAllElements('response').firstWhere(
      (element) => element.getAttribute('name') == 'response_token');
  return responseTokenElement.getAttribute('value').toString();
}

//Step:3 Authentication

Future<List<dynamic>> authenticate(
    userName, password, response_token, suffix) async {
  final url = 'https://agae.tn.nic.in/OnlineGPF_API/Login/LoginSubmit';
  http.Response response = await http.post(
    Uri.parse(url),
    body: {
      'username': userName,
      'password': password,
      'token': 'agsEncryptionKey',
      'response_token': response_token,
      'active_status': 'true',
      'suffix': suffix,
    },
  );
  final value3 = jsonDecode(response.body);
  print('response_body:$value3');
  print('response : $value3');
  final xml2json = Xml2Json();
  xml2json.parse(value3);
  final jsonString = xml2json.toOpenRally();
  final jsonObject = json.decode(jsonString);
  print(jsonObject);
  List list = [];
  String name = jsonObject['ags']['response'][1]['value'];
  String designation = jsonObject['ags']['response'][2]['value'];
  list.add(name);
  list.add(designation);
  return list;
}

//Encrypt Password

Future<String> ecryptPassword(pwd, token) async {
  final url = 'https://agae.tn.nic.in/OnlineGPF_API/Login/EncryptPassword';
  http.Response response = await http.post(Uri.parse(url), body: {
    'password': pwd,
    'response_token': token, //nedumaran.p@gurunanakcollege.edu.in
  });
  print('pwd: ${response.body}');
  return response.body as String;
}

// response : <ags><response name='00' value='Success'/><response name='Name' value='LOGANATHAN S'/><response name='Designation' value='JUNIOR INSPECTOR'/><response name='office' value='ASSISTANT DIRECTOR OF SERICULTURE,TALAVADY ROAD & POST,'/><response name='OfficeAddress' value='TALAVADY TALUK, ERODE DISTRICT - 638 461'/><response name='PensionAmount' value='10300'/><response name='Pension treasury' value='ERODE'/><response name='Pension Sub Treasury' value='SATHYAMANGALAM'/><response name='DCRY Treasury' value=' ERODE'/><response name='PPO No' value='R2718998'/></ags>
// {ags: {response: [{name: 00, value: Success}, {name: Name, value: LOGANATHAN S}, {name: Designation, value: JUNIOR INSPECTOR}, {name: office, value: ASSISTANT DIRECTOR OF SERICULTURE,TALAVADY ROAD & POST,}, {name: OfficeAddress, value: TALAVADY TALUK, ERODE DISTRICT - 638 461}, {name: PensionAmount, value: 10300}, {name: Pension treasury, value: ERODE}, {name: Pension Sub Treasury, value: SATHYAMANGALAM}, {name: DCRY Treasury, value:  ERODE}, {name: PPO No, value: R2718998}]}}
