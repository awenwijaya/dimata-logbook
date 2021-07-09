import 'dart:convert';

import 'package:dimata_logbook/superAdmin/bottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dimata_logbook/shared/loading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:dimata_logbook/superAdmin/profileSuperAdmin/profileSuperAdmin.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';

class editProfileSuperAdmin extends StatefulWidget {
  const editProfileSuperAdmin({Key key}) : super(key: key);

  @override
  _editProfileSuperAdminState createState() => _editProfileSuperAdminState();
}

class _editProfileSuperAdminState extends State<editProfileSuperAdmin> {
  TextEditingController controllerFullName;
  TextEditingController controllerEmail;
  TextEditingController controllerPassword;
  bool Loading = false;
  var employeeId = "2";
  var apiURL = "http://192.168.43.149:8080/api/user";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerFullName = new TextEditingController(text: profileSuperAdmin.fullName);
    controllerEmail = new TextEditingController(text: profileSuperAdmin.superAdminEmail);
    controllerPassword = new TextEditingController(text: loginPage.userPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Loading ? loading() : Scaffold(
      appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Text("Edit Profile")
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("images/logo_logbook.png"),
                  height: 180,
                  width: 180,
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  margin: EdgeInsets.only(top: 10, left: 30)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38, vertical: 8),
                  child: TextFormField(
                    controller: controllerFullName,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: profileSuperAdmin.fullName
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  margin: EdgeInsets.only(top: 20, left: 30)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38, vertical: 8),
                  child: TextFormField(
                    controller: controllerEmail,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: profileSuperAdmin.superAdminEmail
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                        margin: EdgeInsets.only(top: 20, left: 30)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 8),
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
              Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    color: HexColor("#074F78"),
                    onPressed: () async {
                      if(controllerPassword.text == '' || controllerEmail.text == '' || controllerFullName.text == '') {
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
                          "userId" : loginPage.userId,
                          "loginId" : profileSuperAdmin.phoneNumber,
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
                              Navigator.of(context).push(PageTransition(child: bottomNavigationSuperAdmin(), type: PageTransitionType.topToBottom));
                            });
                          }
                        });
                      }
                    },
                    child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 17)),
                  ),
                  margin: EdgeInsets.only(top: 15)
              )
            ]
        ),
      ),
    );
  }
}
