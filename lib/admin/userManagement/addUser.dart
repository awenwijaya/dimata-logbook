import 'dart:convert';

import 'package:dimata_logbook/admin/userManagement/userManagementAdmin.dart';
import 'package:dimata_logbook/shared/loading.dart';
import 'package:dimata_logbook/superAdmin/managements/adminManagement/adminManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:http/http.dart' as http;

class addUserPage extends StatefulWidget {
  const addUserPage({Key key}) : super(key: key);

  @override
  _addUserPageState createState() => _addUserPageState();
}

class _addUserPageState extends State<addUserPage> {
  final controllerloginId = TextEditingController();
  final controllerFullName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool Loading = false;
  var apiURL = "http://192.168.43.149:8080/api/user/add";
  var employeeId = "0";

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
                    Navigator.of(context).push(PageTransition(child: userManagementAdminPage(), type: PageTransitionType.topToBottom));
                  },
                  icon: Icon(Icons.arrow_back)
              ),
              Text("Add User")
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
                            "Add New User",
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
                child: Container(
                  child: RaisedButton(
                    onPressed: () async {
                      if(controllerEmail.text == '' || controllerFullName.text == '' || controllerloginId.text ==  '' || controllerPassword.text == '') {
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
                          "employeeId" : employeeId,
                          "companyId" : loginPage.companyId
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
                                      title: Text('User Already Exists!'),
                                      content: Container(
                                        child: Text("User you tried to add is already exists! Please try add another admin data"),
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
