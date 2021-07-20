import 'dart:convert';

import 'package:dimata_logbook/admin/userManagement/userDetails.dart';
import 'package:dimata_logbook/admin/userManagement/userManagementAdmin.dart';
import 'package:dimata_logbook/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:http/http.dart' as http;

class editUserPage extends StatefulWidget {
  const editUserPage({Key key}) : super(key: key);

  @override
  _editUserPageState createState() => _editUserPageState();
}

class _editUserPageState extends State<editUserPage> {
  bool Loading = false;
  TextEditingController controllerloginId;
  TextEditingController controllerFullName;
  TextEditingController controllerEmail;
  TextEditingController controllerPassword;
  var employeeId = "0";
  var apiURL = "http://192.168.18.10:8080/api/user";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerloginId = new TextEditingController(text: userDetailPage.loginId);
    controllerFullName = new TextEditingController(text: userDetailPage.fullName);
    controllerEmail = new TextEditingController(text: userDetailPage.email);
    controllerPassword = new TextEditingController(text: userDetailPage.password);
  }

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
              Text("Edit User")
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
                            "Edit User",
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
                      if(controllerPassword.text == '' || controllerEmail.text == '' || controllerFullName.text == '' || controllerloginId.text == '') {
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
                          "userId" : userDetailPage.userId,
                          "loginId" : controllerloginId.text,
                          "fullName" : controllerFullName.text,
                          "email" : controllerEmail.text,
                          "password" : controllerPassword.text,
                          "employeeId" : employeeId,
                          "companyId" : loginPage.companyId
                        });
                        http.put(Uri.parse(apiURL),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                        ).then((http.Response response) {
                          var responseValue = response.statusCode;
                          if(responseValue == 200) {
                            setState(() {
                              Loading = false;
                              Navigator.of(context).push(PageTransition(child: userManagementAdminPage(), type: PageTransitionType.topToBottom));
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
                              CupertinoIcons.floppy_disk,
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
