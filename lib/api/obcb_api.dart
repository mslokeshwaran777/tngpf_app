import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> getobcb(
    userName, password, res_token, suf,year) async {
  List obcb = [];
  var res = '';
  http.Response response = await http.post(
      Uri.parse("https://agae.tn.nic.in/OnlineGPF_API/OBCBDetails"),
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
  print('response_body:$res');
  obcb = json.decode(res)['WYFNASMA$year'].toList();
  print("obcb: $obcb");
  return obcb;
}

//Response

// {
// "WYFNASMA2021": [
// {
// "Year": "2021 - 20211",
// "Category": "Opening Balance",
// "GPF": 693710,
// "PCA": null,
// "PCA2": null,
// "UGC": null,
// "UGC2": null,
// "IDA3": null,
// "UG2": null
// },
// {
// "Year": null,
// "Category": "Closing Balance",
// "GPF": 338380,
// "PCA": null,
// "PCA2": null,
// "UGC": null,
// "UGC2": null,
// "IDA3": null,
// "UG2": null
// }
// ]
// }