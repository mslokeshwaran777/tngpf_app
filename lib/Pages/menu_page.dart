//Menu Page

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngpf/Pages/current_balance_details.dart';
import 'package:tngpf/Pages/obcb_dropdown.dart';
import 'package:tngpf/Pages/crdrd_dropdown.dart';
import 'package:tngpf/Pages/login.dart';
import 'package:tngpf/Pages/view_account_slip.dart';
import 'dart:io';
import '../api/curr_bal_api.dart';

class Menu extends StatefulWidget {
  final String directory;
  final String userName;
  final String password;
  final String response_token;
  final String name;
  final String suffix;
  final String GPFNumber;
  final String designation;

  const Menu(
      {Key? key,
      required this.name,
      required this.suffix,
      required this.GPFNumber,
      required this.designation, required this.userName, required this.password, required this.response_token, required this.directory})
      : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool isLoading=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List Topics = [
    "Current Balance",
    "View Account Slips",
    "Opening / Closing Balance",
    "Credit / Debit Details",
    // "Missing Credit Details",
    // "Ledger Card Details",
    // "Final Withdrawl Slips",
    // "Final Withdrawl Intimation"
  ];
  bool _isDialogShown=false;
  String pin='';
  List<TextEditingController> enterpincontrollers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  List<FocusNode> enterpinfocusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );
  List<TextEditingController> seenterpincontrollers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  List<FocusNode> seenterpinfocusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );
  List<TextEditingController> scenterpincontrollers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  List<FocusNode> scenterpinfocusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );
  List<TextEditingController> coenterpincontrollers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  List<FocusNode> coenterpinfocusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );
  List<TextEditingController> cnenterpincontrollers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  List<FocusNode> cnenterpinfocusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );
  List<TextEditingController> ccenterpincontrollers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  List<FocusNode> ccenterpinfocusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );


  @override
  void initState() {
    // TODO: implement initState
    showDialogBox();
  }

  void showDialogBox() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pin=prefs.getString('pin') ?? '';
    prefs.setBool('changepwd', false);
    print('pin=$pin');
    showDialog(
      barrierColor: Colors.black,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: (pin==''?Text('Set Pin'):Text('Enter Pin')),
          content: (pin==''?Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text('ENTER PIN',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                          (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                            controller: seenterpincontrollers[index],
                            focusNode: seenterpinfocusNodes[index],
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            maxLengthEnforcement: null,
                            onChanged: (String value) {
                              if (value.length == 1 && index < 3) {
                                FocusScope.of(context).requestFocus(seenterpinfocusNodes[index + 1]);
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).requestFocus(seenterpinfocusNodes[index - 1]);
                              }
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('CONFIRM PIN',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                          (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                            controller: scenterpincontrollers[index],
                            focusNode: scenterpinfocusNodes[index],
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            maxLengthEnforcement: null,
                            onChanged: (String value) {
                              if (value.length == 1 && index < 3) {
                                FocusScope.of(context).requestFocus(scenterpinfocusNodes[index + 1]);
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).requestFocus(scenterpinfocusNodes[index - 1]);
                              }
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ):Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                    (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                      controller: enterpincontrollers[index],
                      focusNode: enterpinfocusNodes[index],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      maxLengthEnforcement: null,
                      onChanged: (String value) {
                        if (value.length == 1 && index < 3) {
                          FocusScope.of(context).requestFocus(enterpinfocusNodes[index + 1]);
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).requestFocus(enterpinfocusNodes[index - 1]);
                        }
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
          actions: <Widget>[
            pin!=''?TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                enterpincontrollers.forEach((controller) {
                  controller.clear();
                });
                showDialog(
                  barrierColor: Colors.black,
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Text('Change Pin'),
                      content: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text('ENTER OLD PIN',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  4,
                                      (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                                        controller: coenterpincontrollers[index],
                                        focusNode: coenterpinfocusNodes[index],
                                        textAlign: TextAlign.center,
                                        maxLength: 1,
                                        maxLengthEnforcement: null,
                                        onChanged: (String value) {
                                          if (value.length == 1 && index < 3) {
                                            FocusScope.of(context).requestFocus(coenterpinfocusNodes[index + 1]);
                                          } else if (value.isEmpty && index > 0) {
                                            FocusScope.of(context).requestFocus(coenterpinfocusNodes[index - 1]);
                                          }
                                        },
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text('ENTER NEW PIN',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  4,
                                      (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                                        controller: cnenterpincontrollers[index],
                                        focusNode: cnenterpinfocusNodes[index],
                                        textAlign: TextAlign.center,
                                        maxLength: 1,
                                        maxLengthEnforcement: null,
                                        onChanged: (String value) {
                                          if (value.length == 1 && index < 3) {
                                            FocusScope.of(context).requestFocus(cnenterpinfocusNodes[index + 1]);
                                          } else if (value.isEmpty && index > 0) {
                                            FocusScope.of(context).requestFocus(cnenterpinfocusNodes[index - 1]);
                                          }
                                        },
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text('CONFIRM NEW PIN',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  4,
                                      (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 50,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                                        controller: ccenterpincontrollers[index],
                                        focusNode: ccenterpinfocusNodes[index],
                                        textAlign: TextAlign.center,
                                        maxLength: 1,
                                        maxLengthEnforcement: null,
                                        onChanged: (String value) {
                                          if (value.length == 1 && index < 3) {
                                            FocusScope.of(context).requestFocus(ccenterpinfocusNodes[index + 1]);
                                          } else if (value.isEmpty && index > 0) {
                                            FocusScope.of(context).requestFocus(ccenterpinfocusNodes[index - 1]);
                                          }
                                        },
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: (){
                            prefs.setString('pin', '');
                            coenterpincontrollers.forEach((controller) {
                              controller.clear();
                            });
                            cnenterpincontrollers.forEach((controller) {
                              controller.clear();
                            });
                            ccenterpincontrollers.forEach((controller) {
                              controller.clear();
                            });
                            prefs.setBool('isLoggedIn', false);
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
                          },
                          child: const Text('Reset'),
                        ),
                        TextButton(
                          onPressed: () {
                            String eopin = '';
                            coenterpincontrollers.forEach((controller) {
                              eopin += controller.text;
                            });
                            if(pin==eopin){
                              String enpin = '';
                              cnenterpincontrollers.forEach((controller) {
                                enpin += controller.text;
                              });
                              String ecpin = '';
                              ccenterpincontrollers.forEach((controller) {
                                ecpin += controller.text;
                              });
                              if(enpin==ecpin && enpin!=''){
                                prefs.setString('pin', enpin);
                                Navigator.pop(context);
                                showDialogBox();
                                coenterpincontrollers.forEach((controller) {
                                  controller.clear();
                                });
                                cnenterpincontrollers.forEach((controller) {
                                  controller.clear();
                                });
                                ccenterpincontrollers.forEach((controller) {
                                  controller.clear();
                                });
                              }
                              else{
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Mismatching Pin'),
                                      content: const Text('Sorry, the PIN entered in the Enter PIN and Confirm PIN fields do not match or it is empty. Please ensure they match for successful completion'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            coenterpincontrollers.forEach((controller) {
                                              controller.clear();
                                            });
                                            ccenterpincontrollers.forEach((controller) {
                                              controller.clear();
                                            });
                                            cnenterpincontrollers.forEach((controller) {
                                              controller.clear();
                                            });
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                            else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Incorrect Old pin'),
                                    content: const Text('Oops! The entered old PIN is invalid. If you have forgotten your old PIN, you can reset it.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          cnenterpincontrollers.forEach((controller) {
                                            controller.clear();
                                          });
                                          coenterpincontrollers.forEach((controller) {
                                            controller.clear();
                                          });
                                          ccenterpincontrollers.forEach((controller) {
                                            controller.clear();
                                          });

                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Change PIN'),
            ):Container(),
            pin==''?TextButton(
              onPressed: () {
                  String sepin = '';
                  seenterpincontrollers.forEach((controller) {
                    sepin += controller.text;
                  });
                  String scpin = '';
                  scenterpincontrollers.forEach((controller) {
                    scpin += controller.text;
                  });
                  if(sepin==scpin && sepin!=''){
                    prefs.setString('pin',sepin);
                    Navigator.pop(context);
                    seenterpincontrollers.forEach((controller) {
                      controller.clear();
                    });
                    scenterpincontrollers.forEach((controller) {
                      controller.clear();
                    });
                  }
                  else{
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Mismatching Pin'),
                          content: const Text('Sorry, the PIN entered in the Enter PIN and Confirm PIN fields do not match or it is empty. Please ensure they match for successful completion'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                seenterpincontrollers.forEach((controller) {
                                  controller.clear();
                                });
                                scenterpincontrollers.forEach((controller) {
                                  controller.clear();
                                });
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
              },
              child: const Text('Confirm'),
            ):TextButton(
              onPressed: () {
                String epin = '';
                enterpincontrollers.forEach((controller) {
                  epin += controller.text;
                });
                if(epin==pin){
                  Navigator.pop(context);
                  enterpincontrollers.forEach((controller) {
                    controller.clear();
                  });
                }
                else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Incorrect Pin'),
                        content: const Text('Oops! The entered PIN is invalid.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              enterpincontrollers.forEach((controller) {
                                controller.clear();
                              });
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
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
          body: Container(
            color: Color(0xFFF5FFFA),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 40.0, 0.0, MediaQuery.of(context).size.width/6.5),
                    child: Container(
                      height: 55,
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.person,
                            color: Colors.brown,
                            size: 35,
                            fill: 1.0,
                          ),
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFEEED5),
                            shape: CircleBorder(),
                            shadowColor: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/2,
                      child: Center(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 150.0,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                          ),
                          itemCount: Topics.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      Topics[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xff4F4842),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Color(0xffFEEED5),
                                ),
                              ),
                              onTap: () async{
                                if(index==0){
                                  setState(() {
                                    isLoading=true;
                                  });
                                  List current_balance= await getCurrentBalance(widget.userName,widget.password,widget.response_token, widget.suffix, "${DateTime.now().year-1}") as List;
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>current_balnce_details(current_balance:current_balance, userName: widget.userName, password: widget.password, response_token: widget.response_token, name:widget.name, suffix: widget.suffix, GPFNumber: widget.GPFNumber, designation: widget.designation, directory: widget.directory,)));
                                  setState(() {
                                    isLoading=false;
                                  });
                                }
                                else if (index == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              view_account_slip(suf: widget.suffix, gpfno:widget.GPFNumber, userName: widget.userName, password: widget.password, token: widget.response_token, name: widget.name, suffix: widget.suffix, designation: widget.designation, directory: widget.directory,)));
                                } else if (index == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => obcb(userName: widget.userName, password: widget.password, token: widget.response_token, suf: widget.suffix, name: widget.name, suffix: widget.suffix, GPFNumber: widget.GPFNumber, designation: widget.designation, directory: widget.directory,)));
                                } else if (index == 3) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              crdrd(userName: widget.userName, password: widget.password, token: widget.response_token, suf: widget.suffix, name: widget.name, suffix: widget.suffix, GPFNumber: widget.GPFNumber, designation: widget.designation, directory: widget.directory,)));
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ),


          //Drawer to Display User profile
          drawer: SafeArea(
            child: Drawer(
              backgroundColor: Color(0xFFF5FFFA),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    color: Color(0xffFEEED5),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.brown,
                      radius: 55.0,
                      child: Icon(
                        Icons.person_2_rounded,
                        color: Colors.white,
                        size: 65.0,
                      ),
                    ),
                    height: 150,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "GPF Number:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 4.0, 4.0, 4.0),
                              child: Text(
                                widget.GPFNumber,
                                style: TextStyle(
                                    fontSize: 22.0,fontWeight:FontWeight.bold ,color: Colors.brown),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Suffix:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 4.0, 4.0, 4.0),
                              child: Text(
                                widget.suffix,
                                style: TextStyle(
                                    fontSize: 22.0,fontWeight: FontWeight.bold ,color: Colors.brown),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Name:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 4.0, 4.0, 4.0),
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                    fontSize: 22.0,fontWeight: FontWeight.bold ,color: Colors.brown),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Designation:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 4.0, 4.0, 4.0),
                              child: Text(
                                widget.designation,
                                style: TextStyle(
                                    fontSize: 22.0,fontWeight: FontWeight.bold ,color: Colors.brown),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Container(
                      child: Container(
                        child: ElevatedButton(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool('isLoggedIn', false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFEEED5),
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
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

Exit(){
  exit(0);
}

