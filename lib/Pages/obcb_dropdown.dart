//Open Balance Closing Balance DropDown Page

import 'package:flutter/material.dart';
import 'package:tngpf/Pages/obcb_details.dart';
import '../api/obcb_api.dart';
import 'menu_page.dart';

class obcb extends StatefulWidget {
  final String directory;
  final String userName;
  final String password;
  final String token;
  final String suf;
  final String name;
  final String suffix;
  final String GPFNumber;
  final String designation;

  const obcb(
      {super.key,
        required this.userName,
        required this.password,
        required this.token,
        required this.suf,
        required this.name,
        required this.suffix,
        required this.GPFNumber,
        required this.designation, required this.directory});
  @override
  State<obcb> createState() => _obcbState();
}

class _obcbState extends State<obcb> {
  Map<String, String> years = {"": "---- Select the year ----"};
  String initial = "---- Select the year ----";
  String year = '';
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (DateTime.now()
        .isBefore(DateTime.parse('${DateTime.now().year}-01-04'))) {
      for (int year = DateTime.now().year - 3;
      year > DateTime.now().year - 43;
      year = year - 1) {
        var year1 = year + 1;
        years.addAll({"$year": "$year-$year1"});
        print(year1);
      }
    } else {
      for (int year = DateTime.now().year - 2;
      year > DateTime.now().year - 43;
      year = year - 1) {
        var year1 = year + 1;
        years.addAll({"$year": "$year-$year1"});
      }
    }
    print("years: $years");
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: WillPopScope(
          onWillPop: () {
            return exit() ?? false;
          },
          child: years.length == 1
              ? Center(child: CircularProgressIndicator())
              : Container(
            color: Color(0xFFF5FFFA),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 40.0, 10.0,
                        MediaQuery.of(context).size.height / 4.5),
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
                                    response_token: widget.token, directory: widget.directory,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.home,
                            size: 35,
                            color: Colors.brown,
                            fill: 1.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFEEED5),
                            shape: CircleBorder(),
                            shadowColor: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 60,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: year,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: years.keys
                              .map<DropdownMenuItem<String>>((String key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  years[key].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              year = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Container(
                        child: ElevatedButton(
                          child: Text(
                            "Get OBCB Details",
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              List cur = await getobcb(
                                  widget.userName,
                                  widget.password,
                                  widget.token,
                                  widget.suf,
                                  year);
                              print(cur);
                              if (cur.length != 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ocbc_details(
                                          ocbc: cur,
                                          year:
                                          years['$year'].toString(),
                                          userName: widget.userName,
                                          password: widget.password,
                                          response_token: widget.token,
                                          name: widget.name,
                                          suffix: widget.suffix,
                                          GPFNumber: widget.GPFNumber,
                                          designation:
                                          widget.designation, directory: widget.directory,
                                        )));
                              } else {
                                snackBar('Invalid Selection');
                              }
                            } catch (e) {
                              snackBar('Invalid Selection');
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFEEED5),
                            padding: EdgeInsets.all(12.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isLoading)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
    );
  }

  exit() {
    Navigator.pop(context);
  }

  snackBar(String Message) {
    final snackbar = SnackBar(
      content: Text(Message),
      duration: const Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
