import 'dart:convert';

import 'package:dimata_logbook/shared/loading.dart';
import 'package:dimata_logbook/superAdmin/managements/adminManagement/adminManagement.dart';
import 'package:dimata_logbook/superAdmin/managements/adminManagement/company/companyList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class addAdminPage extends StatefulWidget {
  static var companyId;
  static var companyName = "No Company Currently Selected";
  static var employeeId = "1";
  const addAdminPage({Key key}) : super(key: key);

  @override
  _addAdminPageState createState() => _addAdminPageState();
}

class _addAdminPageState extends State<addAdminPage> {
  final controllerloginId = TextEditingController();
  final controllerFullName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool Loading = false;
  var apiURL = "http://192.168.43.149:8080/api/user/add";

  @override
  Widget build(BuildContext context) {
    return Loading ? loading() : MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Row(
            children: <Widget>[
              IconButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: adminManagementPage(), type: PageTransitionType.topToBottom));
                  },
                  icon: Icon(Icons.arrow_back)
              ),
              Text("Add Admin")
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  child: Row(
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          child: Text(
                            "Add New Admin",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                            child: Text(
                              "* = required",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 17
                              ),
                            ),
                            margin: EdgeInsets.only(left: 80)
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(top: 20, left: 20)
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Full Name *",
                          style: TextStyle(fontSize: 15),
                        ),
                        margin: EdgeInsets.only(top: 20, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 8
                        ),
                        child: TextField(
                            controller: controllerFullName,
                            decoration: InputDecoration(
                                hintText: "Full Name"
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Phone Number *",
                          style: TextStyle(fontSize: 15),
                        ),
                        margin: EdgeInsets.only(top: 20, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 8
                        ),
                        child: TextField(
                            controller: controllerloginId,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Phone Number"
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email *",
                          style: TextStyle(fontSize: 15),
                        ),
                        margin: EdgeInsets.only(top: 20, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 8
                        ),
                        child: TextField(
                            controller: controllerEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "Email"
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Password *",
                          style: TextStyle(fontSize: 15),
                        ),
                        margin: EdgeInsets.only(top: 20, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 8
                        ),
                        child: TextField(
                            controller: controllerPassword,
                            decoration: InputDecoration(
                                hintText: "Password"
                            ),
                          obscureText: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Company",
                        style: TextStyle(fontSize: 15),
                      ),
                        margin: EdgeInsets.only(top: 10, left: 20)
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        addAdminPage.companyName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                        margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: (){
                          Navigator.of(context).push(PageTransition(child: companyListPage(), type: PageTransitionType.bottomToTop));
                        },
                        child: Text("Select Company"),
                      ),
                        margin: EdgeInsets.only(top: 10)
                    )
                  ],
                ),
              ),
              Positioned(
                child: Container(
                  child: RaisedButton(
                    onPressed: () async {
                      if(controllerFullName.text == '' || controllerPassword.text == '' || controllerEmail.text == '' || controllerPassword == '' || addAdminPage.companyId == null) {
                        Fluttertoast.showToast(
                            msg: "There are some fields are empty. Please fill the empty field before continue",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            fontSize: 14
                        );
                      } else {
                        setState(() {
                          Loading = true;
                        });
                        var body = jsonEncode({
                          "loginId" : controllerloginId.text,
                          "fullName" : controllerFullName.text,
                          "email" : controllerEmail.text,
                          "password" : controllerPassword.text,
                          "employeeId" : addAdminPage.employeeId,
                          "companyId" : addAdminPage.companyId
                        });
                        http.post(Uri.parse(apiURL),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                        ).then((http.Response response) {
                          var responseValue = response.statusCode;
                          if(response.statusCode == 200) {
                            setState(() {
                              Loading = false;
                              Navigator.of(context).push(PageTransition(child: adminManagementPage(), type: PageTransitionType.topToBottom));
                            });
                          } else {
                            setState(() {
                              Loading = false;
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Admin Already Exists!'),
                                      content: Container(
                                        child: Text("User admin you tried to add is already exists! Please try add another admin data"),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: (){Navigator.of(context).pop();},
                                        )
                                      ],
                                    );
                                  }
                              );
                            });
                          }
                        });
                      }
                    },
                    color: HexColor("#074F78"),
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: Icon(
                              Icons.add,
                              color: Colors.white
                          ),
                        ),
                        Container(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                              ),
                            ),
                            margin: EdgeInsets.only(left: 15)
                        )
                      ],
                    ),
                  ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 140),
                    margin: EdgeInsets.only(top: 25)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
