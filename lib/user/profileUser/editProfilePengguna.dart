import 'dart:convert';

import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:dimata_logbook/user/bottomNavigation.dart';
import 'package:dimata_logbook/user/profileUser/profileUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dimata_logbook/shared/loading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class editProfilePengguna extends StatefulWidget {
  const editProfilePengguna({Key key}) : super(key: key);

  @override
  _editProfilePenggunaState createState() => _editProfilePenggunaState();
}

class _editProfilePenggunaState extends State<editProfilePengguna> {
  TextEditingController controllerFullName;
  TextEditingController controllerEmail;
  TextEditingController controllerPhoneNumber;
  bool Loading = false;
  var apiURL = "http://192.168.18.10:8080/api/user";
  @override
  void initState() {
    super.initState();
    controllerFullName = new TextEditingController
      (text: profilePengguna.fullName);
    controllerEmail = new TextEditingController
      (text: profilePengguna.userEmail);
    controllerPhoneNumber = new TextEditingController
      (text: profilePengguna.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){Navigator.pop(context);}
              ),
              Text("Edit Profile")
            ],
          )
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Container(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage("images/logo_logbook.png"),
                    height: 180,
                    width: 180,
                  )
              ),
              new Container(
                  alignment: Alignment.topLeft,
                  child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  margin: EdgeInsets.only(top: 10, left: 30)
              ),
              new Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38, vertical: 8),
                  child: TextFormField(
                    controller: controllerFullName,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: profilePengguna.fullName,
                    ),
                  ),
                )
              ),
              new Container(
                alignment: Alignment.topLeft,
                child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                margin: EdgeInsets.only(top: 20, left: 30)
              ),
              new Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38, vertical: 8),
                  child: TextFormField(
                    controller: controllerEmail,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: profilePengguna.userEmail
                    ),
                  ),
                )
              ),
              new Container(
                alignment: Alignment.topLeft,
                child: Text("Phone Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                margin: EdgeInsets.only(top: 20, left: 30)
              ),
              new Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38, vertical: 8),
                  child: TextFormField(
                    controller: controllerPhoneNumber,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: profilePengguna.phoneNumber
                    ),
                  ),
                ),
              ),
              new Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: HexColor("#074F78"),
                  onPressed: (){
                    if(controllerFullName.text == '' || controllerEmail.text == '' || controllerPhoneNumber.text == '') {
                      Fluttertoast.showToast(
                        msg: "Both full name, email or phone number field can't be empty! Please try again",
                        fontSize: 14,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER
                      );
                    } else {
                      setState(() => Loading = true);
                      var body = jsonEncode({
                        'userId' : loginPage.userId,
                        'loginId' : controllerPhoneNumber.text,
                        'fullName' : controllerFullName.text,
                        'userType' : 1,
                        'employeeId' : 123,
                        'description' : 'test',
                        'password' : loginPage.userPassword,
                        'email' : controllerEmail.text
                      });
                      http.put(Uri.parse(apiURL),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var data = response.statusCode;
                        if(data == 200) {
                          setState(() {
                            Loading = false;
                            Navigator.push(
                                context,
                                PageTransition(
                                  child: bottomNavigation(),
                                  type: PageTransitionType.topToBottom
                                )
                            );
                          });
                        }
                      });
                    }
                  },
                  child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
                margin: EdgeInsets.only(top: 15),
              )
            ],
          ),
        ),
      )
    );
  }
}
