//Crdrd Details Displaying page

import 'package:flutter/material.dart';
import 'package:tngpf/pdf/crdrd_details_pdf.dart';
import 'menu_page.dart';

class crdrd_menu extends StatefulWidget {
  final String directory;
  final List crdrd;
  final String year;
  final String userName;
  final String password;
  final String response_token;
  final String name;
  final String suffix;
  final String GPFNumber;
  final String designation;

  const crdrd_menu(
      {super.key,
      required this.crdrd,
      required this.year,
      required this.userName,
      required this.password,
      required this.response_token,
      required this.name,
      required this.suffix,
      required this.GPFNumber,
      required this.designation, required this.directory});

  @override
  State<crdrd_menu> createState() => _crdrd_menuState();
}

class _crdrd_menuState extends State<crdrd_menu> {
  List cdata = [];
  List ddata = [];
  List crdrd = [];
  String Year = 'error';

  @override
  void initState() {
    // TODO: implement initState
    crdrd = widget.crdrd;
    Year = widget.year;
    cdata = crdrd[0];
    ddata = crdrd[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            child: const Center(
              child: Text(
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

        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 30.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Menu(
                                      name: widget.name,
                                      suffix: widget.suffix,
                                      GPFNumber: widget.GPFNumber,
                                      designation: widget.designation,
                                      userName: widget.userName,
                                      password: widget.password,
                                      response_token: widget.response_token, directory: widget.directory,)));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFEEED5),
                            shape: CircleBorder(),
                            shadowColor: Colors.black),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.home,
                            size: 35,
                            color: Colors.brown,
                            fill: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 1.6,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              Year,
                              style: const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: ExpansionTile(
                              shape:
                                  Border.all(color: Colors.black, width: 1.25),
                              collapsedShape:
                                  Border.all(color: Colors.black, width: 1.25),
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              collapsedBackgroundColor: Color(0xffFEEED5),
                              collapsedTextColor: Colors.black,
                              title: const Text('Credits',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: DataTable(
                                    columnSpacing: 40,
                                    headingTextStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    dataTextStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    border: const TableBorder(
                                      bottom: BorderSide(color: Colors.black),
                                      top: BorderSide(color: Colors.black),
                                      left: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black),
                                      horizontalInside:
                                          BorderSide(color: Colors.black),
                                      verticalInside:
                                          BorderSide(color: Colors.black),
                                    ),
                                    columns: const [
                                      DataColumn(
                                          label: Center(child: Text('Date'))),
                                      DataColumn(
                                          label: Center(child: Text('Amount'))),
                                      DataColumn(
                                          label: Center(
                                              child: Text('Description'))),
                                    ],
                                    rows: cdata.map((row) {
                                      return DataRow(cells: [
                                        DataCell(Center(
                                            child: Text(row[0].toString(),
                                                textAlign: TextAlign.center))),
                                        DataCell(Center(
                                            child: Text('${row[1]}0',
                                                textAlign: TextAlign.center))),
                                        DataCell(Center(
                                            child: Text(row[2].toString(),
                                                textAlign: TextAlign.center))),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: ExpansionTile(
                              shape:
                                  Border.all(color: Colors.black, width: 1.25),
                              collapsedShape:
                                  Border.all(color: Colors.black, width: 1.25),
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              collapsedBackgroundColor: Color(0xffFEEED5),
                              collapsedTextColor: Colors.black,
                              title: const Text('Debits',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: DataTable(
                                    columnSpacing: 40.0,
                                    headingTextStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    dataTextStyle: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    border: const TableBorder(
                                      bottom: BorderSide(color: Colors.black),
                                      top: BorderSide(color: Colors.black),
                                      left: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black),
                                      horizontalInside:
                                          BorderSide(color: Colors.black),
                                      verticalInside:
                                          BorderSide(color: Colors.black),
                                    ),
                                    columns: const [
                                      DataColumn(
                                          label: Center(
                                              child: Text('Date',
                                                  textAlign:
                                                      TextAlign.center))),
                                      DataColumn(
                                          label: Center(
                                              child: Text('Amount',
                                                  textAlign:
                                                      TextAlign.center))),
                                      DataColumn(
                                          label: Center(
                                              child: Text('Description',
                                                  textAlign:
                                                      TextAlign.center))),
                                    ],
                                    rows: ddata.map((row) {
                                      return DataRow(cells: [
                                        DataCell(Center(
                                            child: Center(
                                                child:
                                                    Text(row[0].toString())))),
                                        DataCell(Center(
                                            child: Center(
                                                child: Text('${row[1]}0')))),
                                        DataCell(Center(
                                            child: Center(
                                                child:
                                                    Text(row[2].toString())))),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              child: ElevatedButton(child: Text('Download as Pdf', style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),), onPressed: (){
                                createcrdrdPdf(crdrd[2], widget.directory,Year);
                                snackBar('File is stored in Downloads....');
                              },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFEEED5),
                                  padding: EdgeInsets.all(12.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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
