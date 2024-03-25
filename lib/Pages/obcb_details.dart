//Open Balance Closing Balance Detail Page

import 'package:flutter/material.dart';
import 'package:tngpf/pdf/ocbc_details_pdf.dart';

import 'menu_page.dart';

class ocbc_details extends StatefulWidget {
  final String directory;
  final List ocbc;
  final String year;
  final String userName;
  final String password;
  final String response_token;
  final String name;
  final String suffix;
  final String GPFNumber;
  final String designation;
  const ocbc_details({super.key, required this.ocbc, required this.year, required this.userName, required this.password, required this.response_token, required this.name, required this.suffix, required this.GPFNumber, required this.designation, required this.directory});

  @override
  State<ocbc_details> createState() => _ocbc_detailsState();
}

class _ocbc_detailsState extends State<ocbc_details> {
  List ocbc=[];
  String Year='error';

  @override
  void initState() {
    // TODO: implement initState
    ocbc=widget.ocbc;
    Year=widget.year;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF5FFFA),
        appBar: AppBar(
          shape: Border(bottom: BorderSide(color: Colors.black,width: 1.5)),
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
            width: MediaQuery.of(context).size.width-150,
            child: Center(
              child: const Text(
                'ACCOUNTANT GENERAL (A&E), TAMILNADU, CHENNAI',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold ,fontSize: 17.0),
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
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> Menu(name: widget.name, suffix: widget.suffix, GPFNumber: widget.GPFNumber, designation: widget.designation, userName: widget.userName, password: widget.password, response_token: widget.response_token, directory: widget.directory,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(Icons.home,size: 35,color:Colors.brown,fill: 1.0,),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFEEED5),
                            shape: CircleBorder(),
                            shadowColor: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/1.6,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              '${Year}',
                              style: TextStyle(
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
                              shape: Border.all(color: Colors.black,width: 1.25),
                              collapsedShape: Border.all(color: Colors.black,width:1.25),
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              collapsedBackgroundColor: Color(0xffFEEED5),
                              collapsedTextColor: Colors.black,
                              title: Text('Opening Balance',
                                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DataTable(
                                    headingTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),
                                    dataTextStyle: TextStyle(fontSize: 15,color: Colors.black),
                                    border: TableBorder(bottom: BorderSide(color: Colors.black),top:BorderSide(color: Colors.black),left: BorderSide(color: Colors.black),right: BorderSide(color: Colors.black),horizontalInside: BorderSide(color: Colors.black),verticalInside: BorderSide(color: Colors.black),),
                                    columns: [
                                      DataColumn(
                                        label: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Details'),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Amount'),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: [
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('GPF')))),
                                            ocbc[0]['GPF']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc[0]['GPF'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('PCA')))),
                                            ocbc[0]['PCA']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc[0]['PCA'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('PCA2')))),
                                            ocbc[0]['PCA2']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc[0]['PCA2'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('UGC')))),
                                            ocbc[0]['UGC']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc[0]['UGC'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('UGC2')))),
                                            ocbc[0]['UGC2']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc[0]['UGC2'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('IDA3')))),
                                            ocbc[0]['IDA3']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc[0]['IDA3'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('UG2')))),
                                            ocbc[0]['UG2']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc[0]['UG2'].toString())))),
                                          ]
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: ExpansionTile(
                              shape: Border.all(color: Colors.black,width: 1.25),
                              collapsedShape: Border.all(color: Colors.black,width:1.25),
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              collapsedBackgroundColor: Color(0xffFEEED5),
                              collapsedTextColor: Colors.black,
                              title: Text('Closing Balance',
                                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DataTable(
                                    headingTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),
                                    dataTextStyle: TextStyle(fontSize: 15,color: Colors.black),
                                    border: TableBorder(bottom: BorderSide(color: Colors.black),top:BorderSide(color: Colors.black),left: BorderSide(color: Colors.black),right: BorderSide(color: Colors.black),horizontalInside: BorderSide(color: Colors.black),verticalInside: BorderSide(color: Colors.black)),
                                    columns: [
                                      DataColumn(
                                        label: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Details'),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Amount'),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: [
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('GPF')))),
                                            ocbc [1]['GPF']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc [1]['GPF'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('PCA')))),
                                            ocbc [1]['PCA']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc [1]['PCA'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('PCA2')))),
                                            ocbc [1]['PCA2']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc [1]['PCA2'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('UGC')))),
                                            ocbc [1]['UGC']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc [1]['UGC'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('UGC2')))),
                                            ocbc [1]['UGC2']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc [1]['UGC2'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('IDA3')))),
                                            ocbc [1]['IDA3']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc [1]['IDA3'].toString())))),
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('UG2')))),
                                            ocbc [1]['UG2']==null?
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('0')))) :
                                            DataCell(Container(child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(ocbc [1]['UG2'].toString())))),
                                          ]
                                      ),
                                    ],
                                  ),
                                )
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
                                createOCBCPdf(ocbc, widget.directory, widget.year);
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
