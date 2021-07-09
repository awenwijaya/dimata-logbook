import 'dart:convert';

import 'package:dimata_logbook/shared/loading.dart';
import 'package:dimata_logbook/superAdmin/bottomNavigation.dart';
import 'package:dimata_logbook/superAdmin/tickets/chapter/chapter.dart';
import 'package:dimata_logbook/superAdmin/tickets/reports/reportType.dart';
import 'package:dimata_logbook/superAdmin/tickets/responsibleUser/responsibleUser.dart';
import 'package:dimata_logbook/superAdmin/tickets/sendTicketBerhasil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:page_transition/page_transition.dart';


class addTicketSuperAdminPage extends StatefulWidget {
  static var reportIdSelected;
  static var reportNameSelected = 'No report type currently selected';
  static var responsibleUserIdSelected;
  static var responsibleUserNameSelected = 'No responsible user selected';
  static var chapterIdSelected;
  static var chapterNameSelected = 'No chapter selected';
  static var reportTypeSelected;
  const addTicketSuperAdminPage({Key key}) : super(key: key);

  @override
  _addTicketSuperAdminPageState createState() => _addTicketSuperAdminPageState();
}

class _addTicketSuperAdminPageState extends State<addTicketSuperAdminPage> {
  int reportByUserId = loginPage.userId;
  bool Loading = false;
  var apiURL = "http://192.168.43.149:8080/api/log-report/add";
  final controllerLogDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Loading ? loading() : MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Row(
            children: <Widget>[
              new IconButton(
                onPressed: (){
                  Navigator.push(context, PageTransition(child: bottomNavigationSuperAdmin(), type: PageTransitionType.topToBottom));
                },
                icon: Icon(Icons.arrow_back)
              ),
              Text("Add Ticket")
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  child: Row(
                      children: <Widget>[
                        new Positioned(
                            child: Container(
                                child: Text(
                                    "Add New Ticket",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    )
                                )
                            )
                        ),
                        new Positioned(
                            child: Container(
                                child: Text(
                                    "* = required",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 17
                                    )
                                ),
                                margin: EdgeInsets.only(left: 80)
                            )
                        )
                      ]
                  ),
                  margin: EdgeInsets.only(top: 20, left: 20)
              ),
              Positioned(
                  child: Column(
                      children: <Widget>[
                        new Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                "Ticket Number *",
                                style: TextStyle(fontSize: 15)
                            ),
                            margin: EdgeInsets.only(top: 20, left: 20)
                        ),
                        new Container(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                              child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      hintText: "Automatic"
                                  )
                              )
                          ),
                        )
                      ]
                  )
              ),
              Positioned(
                  child: Column(
                    children: <Widget>[
                      new Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                              "Ticket Description *",
                              style: TextStyle(fontSize: 15)
                          ),
                          margin: EdgeInsets.only(top: 5, left: 20)
                      ),
                      new Container(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                              child: TextField(
                                  controller: controllerLogDescription,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()
                                  )
                              )
                          )
                      )
                    ],
                  )
              ),
              new Positioned(
                  child: Column(
                      children: <Widget>[
                        new Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                "Report Type *",
                                style: TextStyle(fontSize: 15)
                            ),
                            margin: EdgeInsets.only(top: 5, left: 20)
                        ),
                        new Container(
                            alignment: Alignment.center,
                            child: Text(
                              addTicketSuperAdminPage.reportNameSelected,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            margin: EdgeInsets.only(top: 10)
                        ),
                        new Container(
                            child: RaisedButton(
                                onPressed: (){
                                  Navigator.of(context).push(PageTransition(child: reportCategoriesSuperAdmin(), type: PageTransitionType.bottomToTop));
                                },
                                child: Text("Select Report Type")
                            ),
                            margin: EdgeInsets.only(top: 10)
                        )
                      ]
                  )
              ),
              new Positioned(
                  child: Column(
                      children: <Widget>[
                        new Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                "Chapter",
                                style: TextStyle(fontSize: 15)
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20)
                        ),
                        new Container(
                            child: Text(
                              addTicketSuperAdminPage.chapterNameSelected,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            margin: EdgeInsets.only(top: 10)
                        )
                      ]
                  )
              ),
              new Positioned(
                  child: Container(
                      child: RaisedButton(
                          onPressed: (){
                            Navigator.push(context, PageTransition(child: chapterSuperAdmin(), type: PageTransitionType.bottomToTop));
                          },
                          child: Text("Select Chapter")
                      ),
                      margin: EdgeInsets.only(top: 10)
                  )
              ),
              new Positioned(
                  child: Column(
                    children: <Widget>[
                      new Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Responsible Person *",
                            style: TextStyle(fontSize: 15),
                          ),
                          margin: EdgeInsets.only(top: 15, left: 20)
                      ),
                      new Container(
                          child: Text(
                            addTicketSuperAdminPage.responsibleUserNameSelected,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10)
                      ),
                      new Container(
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.of(context).push(PageTransition(child: responsibleUserSuperAdmin(), type: PageTransitionType.bottomToTop));
                            },
                            child: Text("Select Responsible Person"),
                          ),
                          margin: EdgeInsets.only(top: 10)
                      )
                    ],
                  )
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        onPressed: () async {
                          if(controllerLogDescription.text == '' || addTicketSuperAdminPage.reportIdSelected == null || addTicketSuperAdminPage.responsibleUserIdSelected == null) {
                            Fluttertoast.showToast(
                              msg: "There are some fields are empty. Please fill the empty field before continue",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                fontSize: 14
                            );
                          } else {
                            setState(() {
                              setState(() {
                                Loading = true;
                              });
                              var body = jsonEncode({
                                "logDesc" : controllerLogDescription.text,
                                "rptTypeId" : addTicketSuperAdminPage.reportIdSelected,
                                "reportByUserId" : reportByUserId,
                                "picUserId" : addTicketSuperAdminPage.responsibleUserIdSelected,
                                "priority" : 0,
                                "information" : null,
                                "statusRpt": addTicketSuperAdminPage.reportTypeSelected,
                              });
                              http.post(Uri.parse(apiURL),
                                  headers: {"Content-Type" : "application/json"},
                                  body: body
                              ).then((http.Response response) {
                                var responseValue = response.statusCode;
                                if(responseValue == 200) {
                                  setState(() {
                                    Loading = false;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => sendTicketBerhasilSuperAdminPage())
                                    );
                                  });
                                }
                              });
                            });
                          }
                        },
                        color: HexColor("#074F78"),
                        elevation: 5,
                        child: Row(
                          children: <Widget>[
                            new Center(
                              child: Icon(
                                  Icons.send,
                                  color: Colors.white
                              ),
                            ),
                            new Container(
                                child: Text(
                                  "Send",
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}