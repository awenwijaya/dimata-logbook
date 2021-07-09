import 'dart:convert';

import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:dimata_logbook/user/notifications/notificationPage.dart';
import 'package:dimata_logbook/user/profileUser/editProfilePengguna.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../homeUser.dart';

class profilePengguna extends StatefulWidget {
  static var userEmail = "Your Name";
  static var phoneNumber = "Your Phone Number";
  static var fullName = "Your Full Name";
  const profilePengguna({Key key}) : super(key: key);

  @override
  _profilePenggunaState createState() => _profilePenggunaState();
}

class _profilePenggunaState extends State<profilePengguna> {

  var apiURL = "http://192.168.43.149:8080/api/user/findByUserId";
  var body = jsonEncode({
    'userId' : loginPage.userId
  });

  getUserInfo() async {
    http.post(Uri.parse(apiURL),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          profilePengguna.userEmail = parsedJson['email'];
          profilePengguna.fullName = parsedJson['fullName'];
          profilePengguna.phoneNumber = parsedJson['loginId'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Text("My Profile"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: (){
                Navigator.push(context, PageTransition(child: notificationPage(), type: PageTransitionType.bottomToTop));
              },
            )
          ],
        ),
        drawer: sideMenuUser(),
        body: Column(
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
              child: Text(profilePengguna.fullName, style: TextStyle(fontSize: 17)),
              margin: EdgeInsets.only(left: 30, top: 15),
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: Text("Email", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              margin: EdgeInsets.only(top: 30, left: 30),
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: Text(profilePengguna.userEmail, style: TextStyle(fontSize: 17)),
              margin: EdgeInsets.only(top: 15, left: 30),
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: Text("Phone Number", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              margin: EdgeInsets.only(top: 30, left: 30)
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: Text(profilePengguna.phoneNumber, style: TextStyle(fontSize: 17)),
              margin: EdgeInsets.only(top: 15, left: 30),
            ),
            new Container(
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: (){
                  Navigator.push(context, PageTransition(
                      child: editProfilePengguna(),
                      type: PageTransitionType.bottomToTop));
                },
                color: HexColor("#074F78"),
                child: Text("Edit Profile", style: TextStyle(color: Colors.white)),
              ),
              margin: EdgeInsets.only(top: 30),
            )
          ],
        )
      ),
    );
  }
}