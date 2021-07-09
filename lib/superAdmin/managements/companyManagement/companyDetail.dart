import 'dart:convert';

import 'package:dimata_logbook/shared/loading.dart';
import 'package:dimata_logbook/superAdmin/managements/companyManagement/companyManagement.dart';
import 'package:dimata_logbook/superAdmin/managements/companyManagement/editCompany.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class companyDetailPage extends StatefulWidget {
  static var companyName = "Company Name";
  static var companyDescription = "Description";
  static var companyCode = "Company Code";
  static var companyId;
  const companyDetailPage({Key key}) : super(key: key);

  @override
  _companyDetailPageState createState() => _companyDetailPageState();
}

class _companyDetailPageState extends State<companyDetailPage> {
  bool Loading = false;
  var apiURL = "http://192.168.43.149:8080/api/super-admin/company/delete";

  @override
  Widget build(BuildContext context) {
    return Loading ? loading() : MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              IconButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: companyManagementPage(), type: PageTransitionType.topToBottom));
                  },
                  icon: Icon(Icons.arrow_back)
              ),
              Text("Company Details"),
            ],
          ),
          backgroundColor: HexColor("#074F78"),
          actions: <Widget>[
            IconButton(
              icon: Icon(CupertinoIcons.pencil),
              onPressed: (){
                Navigator.of(context).push(PageTransition(child: editCompanyPage(), type: PageTransitionType.bottomToTop));
              },
              tooltip: "Edit Company",
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Company Name",
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
                    companyDetailPage.companyName,
                  style: TextStyle(
                    fontSize: 17
                  ),
                ),
                  margin: EdgeInsets.only(left: 30, top: 15)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Company Description",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                ),
                margin: EdgeInsets.only(top: 30, left: 30),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  companyDetailPage.companyDescription,
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),
                margin: EdgeInsets.only(top: 15, left: 30),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Company Code",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                ),
                  margin: EdgeInsets.only(top: 30, left: 30)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  companyDetailPage.companyCode.toString(),
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
                      "companyId" : companyDetailPage.companyId
                    });
                    http.delete(Uri.parse(apiURL),
                      headers: {"Content-Type" : "application/json"},
                      body: body
                    ).then((http.Response responsse) {
                      var responseValue = responsse.statusCode;
                      if(responseValue == 200) {
                        setState(() {
                          Loading = false;
                          Navigator.of(context).push(PageTransition(child: companyManagementPage(), type: PageTransitionType.topToBottom));
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
                                "Delete Company",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
