import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngpf/models/suffix_model.dart';

Future<List<Suffix>?> fetchSuffix() async{
  var url=Uri.parse('https://agae.tn.nic.in/OnlineGPF_API/Suffix');
  // var url=Uri.parse('http://192.168.43.129:5000/suffix');

  try {
    final response = await http.post(url);
    print('response_body:${response.body}');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((json) => Suffix.fromJson(json)).toList();
    }
    else {
      print('Error: ');
      print(response.statusCode);
    }
  }
  catch(e){
    print("Exception Occured:");
    print(e);
  }
  return null;
}

// Response
//
// [
//     {
//         "msufix": "",
//         "MDeptlst": "-- Select Suffix --"
//     },
//     {
//         "msufix": "AGRI",
//         "MDeptlst": "AGRI"
//     },
//     {
//         "msufix": "AGRIP",
//         "MDeptlst": "AGRIP"
//     },
//     {
//         "msufix": "AIS",
//         "MDeptlst": "AIS"
//     },
//     {
//         "msufix": "COOP",
//         "MDeptlst": "COOP"
//     },
//     {
//         "msufix": "COOPP",
//         "MDeptlst": "COOPP"
//     },
//     {
//         "msufix": "CT",
//         "MDeptlst": "CT"
//     },
//     {
//         "msufix": "CTP",
//         "MDeptlst": "CTP"
//     },
//     {
//         "msufix": "CVD",
//         "MDeptlst": "CVD"
//     },
//     {
//         "msufix": "EDN",
//         "MDeptlst": "EDN"
//     },
//     {
//         "msufix": "EDNP",
//         "MDeptlst": "EDNP"
//     },
//     {
//         "msufix": "FOR",
//         "MDeptlst": "FOR"
//     },
//     {
//         "msufix": "FORP",
//         "MDeptlst": "FORP"
//     },
//     {
//         "msufix": "GA",
//         "MDeptlst": "GA"
//     },
//     {
//         "msufix": "GAP",
//         "MDeptlst": "GAP"
//     },
//     {
//         "msufix": "IND",
//         "MDeptlst": "IND"
//     },
//     {
//         "msufix": "INDP",
//         "MDeptlst": "INDP"
//     },
//     {
//         "msufix": "JAILS",
//         "MDeptlst": "JAILS"
//     },
//     {
//         "msufix": "JUDL",
//         "MDeptlst": "JUDL"
//     },
//     {
//         "msufix": "JUDLP",
//         "MDeptlst": "JUDLP"
//     },
//     {
//         "msufix": "LR",
//         "MDeptlst": "LR"
//     },
//     {
//         "msufix": "LRP",
//         "MDeptlst": "LRP"
//     },
//     {
//         "msufix": "MEDL",
//         "MDeptlst": "MEDL"
//     },
//     {
//         "msufix": "MEDLP",
//         "MDeptlst": "MEDLP"
//     },
//     {
//         "msufix": "MISC",
//         "MDeptlst": "MISC"
//     },
//     {
//         "msufix": "MISCP",
//         "MDeptlst": "MISCP"
//     },
//     {
//         "msufix": "MTPF",
//         "MDeptlst": "MTPF"
//     },
//     {
//         "msufix": "PH",
//         "MDeptlst": "PH"
//     },
//     {
//         "msufix": "PHP",
//         "MDeptlst": "PHP"
//     },
//     {
//         "msufix": "POL",
//         "MDeptlst": "POL"
//     },
//     {
//         "msufix": "POLP",
//         "MDeptlst": "POLP"
//     },
//     {
//         "msufix": "PORTS",
//         "MDeptlst": "PORTS"
//     },
//     {
//         "msufix": "PTPF",
//         "MDeptlst": "PTPF"
//     },
//     {
//         "msufix": "PW",
//         "MDeptlst": "PW"
//     },
//     {
//         "msufix": "PWP",
//         "MDeptlst": "PWP"
//     },
//     {
//         "msufix": "REGN",
//         "MDeptlst": "REGN"
//     },
//     {
//         "msufix": "SCI",
//         "MDeptlst": "SCI"
//     },
//     {
//         "msufix": "SCIP",
//         "MDeptlst": "SCIP"
//     },
//     {
//         "msufix": "SP",
//         "MDeptlst": "SP"
//     },
//     {
//         "msufix": "SPP",
//         "MDeptlst": "SPP"
//     },
//     {
//         "msufix": "VETY",
//         "MDeptlst": "VETY"
//     },
//     {
//         "msufix": "VETYP",
//         "MDeptlst": "VETYP"
//     },
//     {
//         "msufix": "WC",
//         "MDeptlst": "WC"
//     }
// ]