import 'dart:convert';

import 'package:dimata_logbook/admin/tickets/chapter/chapter.dart';
import 'package:dimata_logbook/admin/tickets/reports/reportType.dart';
import 'package:dimata_logbook/admin/tickets/responsibleUser/responsibleUser.dart';
import 'package:dimata_logbook/admin/tickets/sendTicketBerhasilAdmin.dart';
import 'package:dimata_logbook/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import '../bottomNavigation.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class addTicketPageAdmin extends StatefulWidget {
  static var reportIdSelected;
  static var reportNameSelected = 'No report type currently selected';
  static var responsibleUserIdSelected;
  static var responsibleUserNameSelected = 'No responsible user selected';
  static var chapterIdSelected;
  static var chapterNameSelected = 'No chapter selected';
  static var reportTypeSelected;
  const addTicketPageAdmin({Key key}) : super(key: key);

  @override
  _addTicketPageAdminState createState() => _addTicketPageAdminState();
}

class _addTicketPageAdminState extends State<addTicketPageAdmin> {
  int reportByUserId = loginPage.userId;
  var apiURL = "http://192.168.43.149:8080/api/log-report/add";
  bool Loading = false;
  final controllerLogDescription = TextEditingController();
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
                  Navigator.push(context, PageTransition(child: bottomNavigationAdmin(), type: PageTransitionType.topToBottom));
                },
                icon: Icon(Icons.arrow_back)
              ),
              Text("Add Ticket")
            ],
          )
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
                          "Add New Ticket",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          )
                        )
                      )
                    ),
                    Positioned(
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
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Ticket Number *",
                        style: TextStyle(fontSize: 15)
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(hintText: "Automatic")
                        )
                      )
                    )
                  ]
                )
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Ticket Description *",
                        style: TextStyle(fontSize: 15)
                      ),
                      margin: EdgeInsets.only(top: 5, left: 20)
                    ),
                    Container(
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
                  ]
                )
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Report Type *",
                        style: TextStyle(fontSize: 15)
                      ),
                      margin: EdgeInsets.only(top: 5, left: 20)
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        addTicketPageAdmin.reportNameSelected,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: (){
                          Navigator.push(context, PageTransition(child: reportCategoriesAdmin(), type: PageTransitionType.bottomToTop));
                        },
                        child: Text("Select Report Type"),
                      ),
                      margin: EdgeInsets.only(top: 10)
                    )
                  ]
                )
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Chapter *",
                        style: TextStyle(
                          fontSize: 15
                        )
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20)
                    ),
                    Container(
                      child: Text(
                        addTicketPageAdmin.chapterNameSelected,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      margin: EdgeInsets.only(top: 10)
                    )
                  ],
                )
              ),
              Positioned(
                child: Container(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(context, PageTransition(child: chapterAdmin(), type: PageTransitionType.bottomToTop));
                    },
                    child: Text("Select Chapter")
                  ),
                  margin: EdgeInsets.only(top: 10)
                )
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Responsible Person *",
                        style: TextStyle(fontSize: 15),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20)
                    ),
                    Container(
                      child: Text(
                        addTicketPageAdmin.responsibleUserNameSelected,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: (){
                          Navigator.push(context, PageTransition(child: responsibleUserAdmin(), type: PageTransitionType.bottomToTop));
                        },
                        child: Text("Select Responsible Person")
                      ),
                      margin: EdgeInsets.only(top: 10)
                    )
                  ]
                )
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        onPressed: () async{
                          if(controllerLogDescription.text == '' || addTicketPageAdmin.reportIdSelected == null || addTicketPageAdmin.responsibleUserIdSelected == null) {
                            Fluttertoast.showToast(
                              msg: "There are some fields are empty. Please fill the empty field before continue",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              fontSize: 14
                            );
                          } else {
                            setState(() => Loading = true);
                            var body = jsonEncode({
                              "logDesc" : controllerLogDescription.text,
                              "rptTypeId" : addTicketPageAdmin.reportIdSelected,
                              "reportByUserId" : reportByUserId,
                              "picUserId" : addTicketPageAdmin.responsibleUserIdSelected,
                              "priority" : 0,
                              "information" : null,
                              "statusRpt": addTicketPageAdmin.reportTypeSelected,
                            });
                            http.post(Uri.parse(apiURL),
                              headers: {"Content-Type" : "application/json"},
                              body: body
                            ).then((http.Response response) {
                              var responseValue = response.statusCode;
                              if(responseValue == 200) {
                                setState(() {
                                  Loading = false;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => sendTicketBerhasilAdminPage()));
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
                                Icons.send,
                                color: Colors.white
                              )
                            ),
                            Container(
                              child: Text(
                                "Send",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                                )
                              ),
                              margin: EdgeInsets.only(left: 15)
                            )
                          ]
                        )
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 140),
                      margin: EdgeInsets.only(top: 25)
                    ),
                    Container(
                      child: TextButton(
                        onPressed: (){},
                        child: Text("Cancel", style: TextStyle(fontSize: 15, color: Colors.black)),
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}