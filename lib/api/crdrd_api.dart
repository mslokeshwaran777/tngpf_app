import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> getcrdrd(
    userName, password, res_token, suf,year) async {
  List crdrd = [];
  var res = '';
  http.Response response = await http.post(
      Uri.parse("https://agae.tn.nic.in/OnlineGPF_API/CRDRDetails"),
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
  print('response_body:$res');
  crdrd = json.decode(res)['MonthwiseDetails'].toList();
  print("crdrd: $crdrd");
  List Amt=[];
  List credit=[];
  List debit=[];
  for(int i=0; i<crdrd.length; i++){
    List temp=[];
    if(crdrd[i]['Debit']==null){
      temp=[];
       temp.add(crdrd[i]['MREFDT']);
       temp.add(crdrd[i]['MPF']);
       temp.add(crdrd[i]['FlagDescription']);
       credit.add(temp);
    }
    else{
      temp=[];
      temp.add(crdrd[i]['MREFDT']);
      crdrd[i]['MAMT1']!=null?temp.add(crdrd[i]['MAMT1']):temp.add(crdrd[i]['Credit']);
      temp.add(crdrd[i]['FlagDescription']);
      debit.add(temp);
    }
  }
  Amt.add(credit);
  Amt.add(debit);
  Amt.add(crdrd);
  print("Amount: $Amt");
  return Amt;
}

// Response
// {
// "MonthwiseDetails": [
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 5.0,
// "MREFDT": "01/04/2022",
// "MPF": 11000.00,
// "MRTN": null,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 5.0,
// "MREFDT": "01/05/2022",
// "MPF": 11000.00,
// "MRTN": null,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 5.0,
// "MREFDT": "01/06/2022",
// "MPF": 11000.00,
// "MRTN": null,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 6.0,
// "MREFDT": "01/07/2022",
// "MPF": 11000.00,
// "MRTN": 0.00,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 7.0,
// "MREFDT": "01/08/2022",
// "MPF": 11400.00,
// "MRTN": 0.00,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 8.0,
// "MREFDT": "01/09/2022",
// "MPF": 11600.00,
// "MRTN": 0.00,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 9.0,
// "MREFDT": "01/10/2022",
// "MPF": 11600.00,
// "MRTN": 0.00,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 10.0,
// "MREFDT": "01/10/2022",
// "MPF": null,
// "MRTN": null,
// "MAMT1": 303200.00,
// "MCAT": "D",
// "MFLG": "L",
// "FlagDescription": "Part Final Withdrawal",
// "Credit": null,
// "Debit": 303200.00
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 10.0,
// "MREFDT": "01/11/2022",
// "MPF": 11600.00,
// "MRTN": 0.00,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 11.0,
// "MREFDT": "01/12/2022",
// "MPF": 11600.00,
// "MRTN": 0.00,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2022.0,
// "MMonth": 12.0,
// "MREFDT": "01/01/2023",
// "MPF": 11600.00,
// "MRTN": 0.00,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2023.0,
// "MMonth": 1.0,
// "MREFDT": "01/02/2023",
// "MPF": 12000.00,
// "MRTN": 0.00,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// },
// {
// "MSUFIX": "EDN",
// "MGPFNO": 159420.0,
// "MYear": 2023.0,
// "MMonth": 2.0,
// "MREFDT": "01/03/2023",
// "MPF": 12000.00,
// "MRTN": 0.00,
// "MAMT1": null,
// "MCAT": "S",
// "MFLG": "G",
// "FlagDescription": "GPF",
// "Credit": null,
// "Debit": null
// }
// ],
// "AdjustmentDetails": []
// }
//
