import 'dart:convert';

import 'package:dimata_logbook/API/models/followUp.dart';
import 'package:dimata_logbook/admin/chatsAdmin/addFollowUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class followUpDetailAdminPage extends StatefulWidget {
  static var ticketNumber = '0000';
  static var ticketStatus = 'In Progress';
  static var ticketStatusId;
  static var ticketDetail = 'Test Ticket Detail';
  static var logReportId;
  const followUpDetailAdminPage({Key key}) : super(key: key);

  @override
  _followUpDetailAdminPageState createState() => _followUpDetailAdminPageState();
}

class _followUpDetailAdminPageState extends State<followUpDetailAdminPage> {
  var apiURLFollowUp = "http://192.168.43.149:8080/api/log-follow-up/get";

  Future<FollowUp> functionListFollowUp() async {
    var body = jsonEncode({
      "logReportId" : followUpDetailAdminPage.logReportId
    });
    return http.post(Uri.parse(apiURLFollowUp),
      headers:  {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final followUpData =  followUpFromJson(body);
        return followUpData;
      } else {
        final body =  response.body;
        final error = followUpFromJson(body);
        return error;
      }
    });
  }

  functionSetTicketStatus() {
    if(followUpDetailAdminPage.ticketStatusId == '0') {
      setState(() {
        followUpDetailAdminPage.ticketStatus = 'Waiting for Support';
      });
    } else if(followUpDetailAdminPage.ticketStatusId == '1') {
      setState(() {
        followUpDetailAdminPage.ticketStatus = 'In Progress';
      });
    } else if(followUpDetailAdminPage.ticketStatusId == '2') {
      setState(() {
        followUpDetailAdminPage.ticketStatusId = 'Done';
      });
    } else {
      setState(() {
        followUpDetailAdminPage.ticketStatus = 'Null';
      });
    }
  }

  Widget followUpList() {
    return FutureBuilder<FollowUp>(
      future: functionListFollowUp(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          if(data.status == "false") {
            return Text("No Follow Up");
          } else {
            final followUpData = data.payload;
            return ListView.builder(
              itemCount: followUpData.length,
              itemBuilder: (context, index) {
                final followUpTikets = followUpData[index];
                return TextButton(
                  onPressed: (){},
                  child: Container(
                      margin: EdgeInsets.only(left: 30, top: 30, right: 30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Follow Up",
                                style: TextStyle(
                                    color: HexColor("#074F78"),
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 17
                                ),
                              ),
                              margin: EdgeInsets.only(bottom: 5, top: 5)
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                followUpTikets.flwNote.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17
                                ),
                              ),
                              margin: EdgeInsets.only(bottom: 15, left: 20)
                          ),
                          Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Start Time: ",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      followUpTikets.startDateTime.toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(bottom: 5, left: 20)
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "End Time: ",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    followUpTikets.endDateTime.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic
                                    ),
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(bottom: 5, left: 20),
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)
                  ),
                );
              },
            );
          }
        } else {
          return Text("No Follow Up");
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functionSetTicketStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){Navigator.of(context).pop();},
              ),
              Text(followUpDetailAdminPage.ticketNumber.toString()),
              Text(" - "),
              Text(followUpDetailAdminPage.ticketStatus)
            ]
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                if(followUpDetailAdminPage.ticketStatus == "Done") {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Can't Add Another Follow Up!"),
                          content: Text("Sorry! You can't add another follow up data because this ticket has been set to Done"),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }
                  );
                } else {
                  Navigator.of(context).push(PageTransition(child: addFollowUpAdminPage(), type: PageTransitionType.bottomToTop));
                }
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30, top: 30, right: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0,3)
                      )
                    ]
                ),
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Ticket Details",
                            style: TextStyle(
                                fontSize: 17,
                                color: HexColor("#074F78"),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 15),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            followUpDetailAdminPage.ticketDetail.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17
                            ),
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)
                ),
              ),
              Container(
                height: 500,
                child: followUpList(),
                margin: EdgeInsets.only(top: 15),
              )
            ],
          ),
        ),
      )
    );
  }
}
