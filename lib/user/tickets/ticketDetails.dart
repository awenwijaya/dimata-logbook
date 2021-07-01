import 'dart:convert';

import 'package:dimata_logbook/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import '../homeUser.dart';

class ticketDetailPage extends StatefulWidget {
  static var reportedBy = 'null';
  static var reportedByUserId;
  static var followUpBy = 'null';
  static var followUpByUserId;
  static var responsiblePerson = 'null';
  static var responsiblePersonUserId;
  static var reportDate = 'null';
  static var reportType = 'null';
  static var tiketDetail = 'null';
  static var ticketIdSelected;
  static var logReportId;
  const ticketDetailPage({Key key}) : super(key: key);

  @override
  _ticketDetailPageState createState() => _ticketDetailPageState();
}

class _ticketDetailPageState extends State<ticketDetailPage> {
  var apiURLPengguna = "http://192.168.18.10:8080/api/user/findByUserId";
  var apiURLDeleteTickets = "http://192.168.18.10:8080/api/log-report/delete";
  bool Loading = false;

  getReportedByUserName() async {
    var body = jsonEncode({
      'userId' : ticketDetailPage.reportedByUserId
    });
    http.post(Uri.parse(apiURLPengguna),
      headers : {"Content-Type" : "application/json"},
      body : body
    ).then((http.Response response) {
      var data = response.statusCode;
      if(data == 200) {
        var jsonBody = json.decode(response.body);
        setState(() {
          ticketDetailPage.reportedBy = jsonBody['fullName'];
        });
      }
    });
  }

  getFollowUpByUserName() async {
    var body = jsonEncode({
      'userId' : ticketDetailPage.followUpByUserId
    });
    http.post(Uri.parse(apiURLPengguna),
      headers : {"Content-Type" : "application/json"},
      body : body
    ).then((http.Response response) {
      var data = response.statusCode;
      if(data == 200) {
        var jsonBody = json.decode(response.body);
        setState(() {
          ticketDetailPage.followUpBy = jsonBody['fullName'];
        });
      }
    });
  }

  getResponsiblePersonUserName() async {
    var body = jsonEncode({
      'userId' : ticketDetailPage.responsiblePersonUserId
    });
    http.post(Uri.parse(apiURLPengguna),
      headers : {"Content-Type" : "application/json"},
      body : body
    ).then((http.Response response) {
      var data = response.statusCode;
      if(data == 200) {
        var jsonBody = json.decode(response.body);
        setState(() {
          ticketDetailPage.responsiblePerson = jsonBody['fullName'];
        });
      }
    });
  }


  getUserNames() {
    getFollowUpByUserName();
    getReportedByUserName();
    getResponsiblePersonUserName();
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserNames();
    super.initState();
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
                icon: Icon(Icons.arrow_back),
                onPressed: (){Navigator.pop(context);}
              ),
              Text("Ticket Details")
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){}
            )
          ]
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        child: Text(
                            "Reported by:",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            )
                        ),
                    ),
                    Container(
                      child: Text(
                        ticketDetailPage.reportedBy.toString(),
                        style: TextStyle(
                          fontSize: 17
                        )
                      ),
                      margin: EdgeInsets.only(left: 10)
                    )
                  ],
                ),
                  margin: EdgeInsets.only(top: 30, left: 25)
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Followed up by :",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        ticketDetailPage.followUpBy.toString(),
                        style: TextStyle(
                          fontSize: 17
                        )
                      ),
                      margin: EdgeInsets.only(left: 10)
                    )
                  ]
                ),
                margin: EdgeInsets.only(top: 30, left: 25)
              ),
              Container(
                  child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                              "Responsible Person :",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        Container(
                            child: Text(
                                ticketDetailPage.responsiblePerson.toString(),
                                style: TextStyle(
                                    fontSize: 17
                                )
                            ),
                            margin: EdgeInsets.only(left: 10)
                        )
                      ]
                  ),
                  margin: EdgeInsets.only(top: 30, left: 25)
              ),
              Container(
                  child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                              "Report Date :",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        Container(
                            child: Text(
                                ticketDetailPage.reportDate,
                                style: TextStyle(
                                    fontSize: 17
                                )
                            ),
                            margin: EdgeInsets.only(left: 10)
                        )
                      ]
                  ),
                  margin: EdgeInsets.only(top: 30, left: 25)
              ),
              Container(
                  child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                              "Report Type :",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        Container(
                            child: Text(
                                ticketDetailPage.reportType,
                                style: TextStyle(
                                    fontSize: 17
                                )
                            ),
                            margin: EdgeInsets.only(left: 10)
                        )
                      ]
                  ),
                  margin: EdgeInsets.only(top: 30, left: 25)
              ),
              Container(
                child: Text(
                  "Tickets Description",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                margin: EdgeInsets.only(top: 30)
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextFormField(
                    enabled: false,
                    maxLines: null,
                    initialValue: ticketDetailPage.tiketDetail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    )
                  )
                ),
                margin: EdgeInsets.only(top: 15)
              ),
              Container(
                child: RaisedButton(
                  onPressed: (){
                    setState(() {
                      Loading = true;
                    });
                    if (loginPage.userId.toString() == ticketDetailPage.reportedByUserId) {
                      var body = jsonEncode({
                        "logReportId" : ticketDetailPage.logReportId
                      });
                      http.delete(Uri.parse(apiURLDeleteTickets),
                          headers : {"Content-Type" : "application/json"},
                          body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                            Navigator.of(context).push(PageTransition(child: homePengguna(), type: PageTransitionType.topToBottom));
                          });
                        }
                      });
                    } else {
                      setState(() {
                        Loading = false;
                      });
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Can't Delete"),
                            content: Text("Sorry! You can't delete ticket because you don't report this ticket"),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: (){Navigator.of(context).pop();},
                              )
                            ]
                          );
                        }
                      );
                    }

                  },
                  color: HexColor("#a81111"),
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Delete Ticket",
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
                      ]
                    )
                  ),
                ),
                  margin: EdgeInsets.only(top: 30, left: 40, right: 40)
              ),
            ],
          )
        )
      )
    );
  }
}
