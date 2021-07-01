import 'dart:convert';

import 'package:dimata_logbook/admin/homeAdmin.dart';
import 'package:dimata_logbook/admin/notification/notificationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class reportPageAdmin extends StatefulWidget {
  const reportPageAdmin({Key key}) : super(key: key);

  @override
  _reportPageAdminState createState() => _reportPageAdminState();
}

class _reportPageAdminState extends State<reportPageAdmin> {
  int reportDoneBugs = 0;
  int reportDoneProblems = 0;
  int reportDoneSupport = 0;
  int reportDoneRequest = 0;
  var apiURLReportDoneBugs = "http://192.168.18.10:8080/api/log-report/count/done/bugs";
  var apiURLReportDoneProblems = "http://192.168.18.10:8080/api/log-report/count/done/problems";
  var apiURLReportDoneSupport = "http://192.168.18.10:8080/api/log-report/count/done/support";
  var apiURLReportDoneRequest = "http://192.168.18.10:8080/api/log-report/count/done/requests";

  setBugs() {
    http.get(Uri.parse(apiURLReportDoneBugs)).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          reportDoneBugs = parsedJson;
        });
      }
    });
  }

  setProblems() {
    http.get(Uri.parse(apiURLReportDoneProblems)).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          reportDoneProblems = parsedJson;
        });
      }
    });
  }

  setSupport() {
    http.get(Uri.parse(apiURLReportDoneSupport)).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          reportDoneSupport = parsedJson;
        });
      }
    });
  }

  setRequest() {
    http.get(Uri.parse(apiURLReportDoneRequest)).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          reportDoneRequest = parsedJson;
        });
      }
    });
  }

  countDone() {
    setBugs();
    setSupport();
    setProblems();
    setRequest();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countDone();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Text("Reports"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: (){Navigator.push(context, PageTransition(child: notificationPageAdmin(), type: PageTransitionType.bottomToTop));},
            )
          ],
        ),
        drawer: sideMenuAdmin(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Positioned(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                      "Report Done",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  margin: EdgeInsets.only(top: 20, left: 20),
                )
              ),
              Positioned(
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                            children: <Widget>[
                              Container(
                                  child: Text(
                                    '$reportDoneBugs',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                  margin: EdgeInsets.only(right: 20)
                              ),
                              Container(
                                child: Text(
                                    "Bugs",
                                    style: TextStyle(
                                        fontSize: 20,
                                      color: Colors.white
                                    )
                                ),
                              )
                            ]
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.bug_report_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: HexColor("#bc6d4c"),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                )
              ),
              Positioned(
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Row(
                              children: <Widget>[
                                Container(
                                    child: Text(
                                      '$reportDoneProblems',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                    ),
                                    margin: EdgeInsets.only(right: 20)
                                ),
                                Container(
                                  child: Text(
                                      "Problems",
                                      style: TextStyle(
                                          fontSize: 20,
                                        color: Colors.white
                                      )
                                  ),
                                )
                              ]
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Icon(
                            CupertinoIcons.gear_alt_fill,
                            size: 25,
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: HexColor("#7e0f12"),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
              ),
              Positioned(
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Row(
                              children: <Widget>[
                                Container(
                                    child: Text(
                                      '$reportDoneSupport',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                    ),
                                    margin: EdgeInsets.only(right: 20)
                                ),
                                Container(
                                  child: Text(
                                      "Support",
                                      style: TextStyle(
                                          fontSize: 20,
                                        color: Colors.white
                                      )
                                  ),
                                )
                              ]
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.build,
                            color: Colors.white,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: HexColor("#6a7045"),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
              ),
              Positioned(
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Row(
                              children: <Widget>[
                                Container(
                                    child: Text(
                                      '$reportDoneRequest',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                    ),
                                    margin: EdgeInsets.only(right: 20)
                                ),
                                Container(
                                  child: Text(
                                      "Requests",
                                      style: TextStyle(
                                          fontSize: 20,
                                        color: Colors.white
                                      )
                                  ),
                                )
                              ]
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Icon(
                            CupertinoIcons.question_diamond_fill,
                            size: 25,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: HexColor("#313c33"),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
              )
            ],
          )
        )
      )
    );
  }
}