import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> getCurrentBalance(
    userName, password, res_token, suf,year) async {
  List curBal = [];
  var res = '';
  http.Response response = await http.post(
      Uri.parse("https://agae.tn.nic.in/OnlineGPF_API/CurrentBalance"),
      body: {
        "username": userName,
        "password": password,
        "response_token": res_token,
        "token": "agsEncryptionKey",
        "active_status": "true",
        "suffix": suf,
        "yr": year,
        "deptcode": suf,
      });
  res = response.body;
  print(res);
  curBal = json.decode(res).toList();
  print("curr_bal: $curBal");
  return curBal;
}

// Api Response

// [
//   {
//     "Category": "Current Opening Balance",
//     "GPF": 693710,
//     "PCA": null,
//     "PCA2": null,
//     "UGC": null,
//     "UGC2": null,
//     "IDA3": null,
//     "UG2": null
//   },
//   {
//     "Category": " Current Year Credit ",
//     "GPF": 120000,
//     "PCA": null,
//     "PCA2": null,
//     "UGC": null,
//     "UGC2": null,
//     "IDA3": null,
//     "UG2": null
//   },
//   {
//     "Category": " OB + Credits ",
//     "GPF": 813710,
//     "PCA": null,
//     "PCA2": null,
//     "UGC": null,
//     "UGC2": null,
//     "IDA3": null,
//     "UG2": null
//   },
//   {
//     "Category": " Current Year Debit ",
//     "GPF": 473000,
//     "PCA": null,
//     "PCA2": null,
//     "UGC": null,
//     "UGC2": null,
//     "IDA3": null,
//     "UG2": null
//   },
//   {
//     "Category": " Current Closing Balance ",
//     "GPF": 340710,
//     "PCA": null,
//     "PCA2": null,
//     "UGC": null,
//     "UGC2": null,
//     "IDA3": null,
//     "UG2": null
//   }
// ];

//[{"Category":"Current Opening Balance","GPF":191043,"PCA":null,"PCA2":null,"UGC":null,"UGC2":null,"IDA3":null,"UG2":null},{"Category":" Current Year Credit ","GPF":112400,"PCA":null,"PCA2":null,"UGC":null,"UGC2":null,"IDA3":null,"UG2":null},{"Category":" OB + Credits ","GPF":303443,"PCA":null,"PCA2":null,"UGC":null,"UGC2":null,"IDA3":null,"UG2":null},{"Category":" Current Year Debit ","GPF":138800,"PCA":null,"PCA2":null,"UGC":null,"UGC2":null,"IDA3":null,"UG2":null},{"Category":" Current Closing Balance ","GPF":164643,"PCA":null,"PCA2":null,"UGC":null,"UGC2":null,"IDA3":null,"UG2":null}]