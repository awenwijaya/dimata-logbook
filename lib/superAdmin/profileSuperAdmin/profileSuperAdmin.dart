import 'dart:convert';

import 'package:dimata_logbook/superAdmin/homeSuperAdmin.dart';
import 'package:dimata_logbook/superAdmin/notifications/notificationPage.dart';
import 'package:dimata_logbook/superAdmin/profileSuperAdmin/editProfileSuperAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:dimata_logbook/loginRegistrasi.dart';

class profileSuperAdmin extends StatefulWidget {
  static var superAdminEmail = "Your Email";
  static var phoneNumber = "Your Phone Number";
  static var fullName = "Your Full Name";
  const profileSuperAdmin({Key key}) : super(key: key);

  @override
  _profileSuperAdminState createState() => _profileSuperAdminState();
}

class _profileSuperAdminState extends State<profileSuperAdmin> {
  var apiURL = "http://192.168.43.149:8080/api/user/findByUserId";
  var body = jsonEncode({
    'userId' : loginPage.userId
  });

  getSuperAdminInfo() async {
    http.post(Uri.parse(apiURL),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          profileSuperAdmin.superAdminEmail = parsedJson['email'];
          profileSuperAdmin.phoneNumber = parsedJson['loginId'];
          profileSuperAdmin.fullName = parsedJson['fullName'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSuperAdminInfo();
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
                Navigator.push(context, PageTransition(child: notificationPageSuperAdmin(), type: PageTransitionType.bottomToTop));
              },
            )
          ],
        ),
        drawer: sideMenuSuperAdmin(),
        body: Column(
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
                child: Text(profileSuperAdmin.fullName, style: TextStyle(fontSize: 17)),
                margin: EdgeInsets.only(left: 30, top: 15)
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text("Email", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              margin: EdgeInsets.only(top: 30, left: 30),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(profileSuperAdmin.superAdminEmail, style: TextStyle(fontSize: 17)),
              margin: EdgeInsets.only(top: 15, left: 30),
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text("Phone Number", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                margin: EdgeInsets.only(top: 30, left: 30)
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text(profileSuperAdmin.phoneNumber, style: TextStyle(fontSize: 17)),
                margin: EdgeInsets.only(top: 15, left: 30)
            ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: (){
                  Navigator.push(context, PageTransition(child: editProfileSuperAdmin(), type: PageTransitionType.bottomToTop));
                },
                color: HexColor("#074F78"),
                child: Text("Edit Profile", style: TextStyle(color: Colors.white)),
              ),
              margin: EdgeInsets.only(top: 30),
            )
          ],
        ),
      )
    );
  }
}
