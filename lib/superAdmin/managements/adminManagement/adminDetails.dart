import 'dart:convert';

import 'package:dimata_logbook/shared/loading.dart';
import 'package:dimata_logbook/superAdmin/managements/adminManagement/adminManagement.dart';
import 'package:dimata_logbook/superAdmin/managements/adminManagement/editAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class adminDetailPage extends StatefulWidget {
  static var userId;
  static var loginId;
  static var fullName;
  static var companyId;
  static var employeeId;
  static var password;
  static var email;
  static var companyName = "null";
  const adminDetailPage({Key key}) : super(key: key);

  @override
  _adminDetailPageState createState() => _adminDetailPageState();
}

class _adminDetailPageState extends State<adminDetailPage> {
  bool Loading = false;
  var apiURLDelete = "http://192.168.43.149:8080/api/user/delete";
  var apiURLCompanyName = "http://192.168.43.149:8080/api/super-admin/company/detail/id";

  setCompanyName() {
    var body = jsonEncode({
      "companyId" : adminDetailPage.companyId
    });
    http.post(Uri.parse(apiURLCompanyName),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          adminDetailPage.companyName = parsedJson['company'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCompanyName();
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
                    Navigator.of(context).push(PageTransition(child: adminManagementPage(), type: PageTransitionType.topToBottom));
                  },
                  icon: Icon(Icons.arrow_back)
              ),
              Text("Admin Details")
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(CupertinoIcons.pencil),
              onPressed: (){
                Navigator.of(context).push(PageTransition(child: editAdminPage(), type: PageTransitionType.bottomToTop));
              },
              tooltip: "Edit Admin",
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Full Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
                margin: EdgeInsets.only(top: 40, left: 30)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  adminDetailPage.fullName.toString(),
                  style: TextStyle(
                    fontSize: 17
                  ),
                ),
                margin: EdgeInsets.only(top: 15, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Phone Number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    adminDetailPage.loginId.toString(),
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 15, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    adminDetailPage.email.toString(),
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 15, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Company",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    adminDetailPage.companyName.toString(),
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 15, left: 30)
              ),
              Container(
                child: RaisedButton(
                  onPressed: (){
                    setState(() {
                      Loading = true;
                    });
                    var body = jsonEncode({
                      "userId" : adminDetailPage.userId
                    });
                    http.delete(Uri.parse(apiURLDelete),
                      headers: {"Content-Type" : "application/json"},
                      body: body
                    ).then((http.Response response) {
                      var responseValue = response.statusCode;
                      if(responseValue == 200) {
                        setState(() {
                          Loading = false;
                          Navigator.of(context).push(PageTransition(child: adminManagementPage(), type: PageTransitionType.topToBottom));
                        });
                      }
                    });
                  },
                  color: HexColor("#a81111"),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Text(
                                "Delete Admin",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white
                                )
                            ),
                            margin: EdgeInsets.only(right: 10)
                        ),
                        Icon(
                            Icons.delete_rounded,
                            size: 15,
                            color: Colors.white
                        )
                      ],
                    ),
                ),
              ),
                  margin: EdgeInsets.only(top: 30, left: 40, right: 40)
              )]
          ),
        ),
      ),
    );
  }
}
