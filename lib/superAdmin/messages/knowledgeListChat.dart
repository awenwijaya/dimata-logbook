import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dimata_logbook/API/models/tickets.dart';
import 'package:http/http.dart' as http;
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/superAdmin/chatsSuperAdmin/followUpDetail.dart';

class knowledgeSuperAdminPage extends StatefulWidget {
  const knowledgeSuperAdminPage({Key key}) : super(key: key);

  @override
  _knowledgeSuperAdminPageState createState() => _knowledgeSuperAdminPageState();
}

class _knowledgeSuperAdminPageState extends State<knowledgeSuperAdminPage> {
  var apiURLListKnowledge = "http://192.168.43.149:8080/api/super-admin/status-report/knowledge";

  Future<Tickets> functionListKnowledge() async {
    var body = jsonEncode({
      "picUserId" : loginPage.userId
    });
    return http.post(Uri.parse(apiURLListKnowledge),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final tiketKnowledge = ticketsFromJson(body);
        return tiketKnowledge;
      } else {
        final body = response.body;
        final error = ticketsFromJson(body);
        return error;
      }
    });
  }

  Widget tiketKnowledgeList() {
    return FutureBuilder<Tickets>(
      future: functionListKnowledge(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          if(data.status == false) {
            return Text("No Tickets");
          } else {
            final tiketData = data.payload;
            return ListView.builder(
              itemCount: tiketData.length,
              itemBuilder: (context, index) {
                final knowledgeTiket = tiketData[index];
                return TextButton(
                  onPressed: (){
                    setState(() {
                      followUpDetailSuperAdminPage.ticketNumber = knowledgeTiket.logNumber.toString();
                      followUpDetailSuperAdminPage.ticketStatusId = knowledgeTiket.status.toString();
                      followUpDetailSuperAdminPage.ticketDetail = knowledgeTiket.logDesc.toString();
                      followUpDetailSuperAdminPage.logReportId = knowledgeTiket.logReportId;
                    });
                    Navigator.of(context).push(PageTransition(child: followUpDetailSuperAdminPage(), type: PageTransitionType.rightToLeft));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.brightness_1,
                                    color: HexColor("#074F78"),
                                    size: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      knowledgeTiket.logNumber.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: HexColor("#074F78"),
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                    margin: EdgeInsets.only(left: 5),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  knowledgeTiket.reportDate.toString(),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(top: 10, left: 10)
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            knowledgeTiket.logDesc.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black26,
                                    width: 1
                                )
                            )
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        } else {
          return Center(
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                          CupertinoIcons.xmark_circle_fill,
                          color: HexColor("#074F78"),
                          size: 20
                      ),
                      Container(
                        child: Text(
                          "No Tickets",
                          style: TextStyle(
                              fontSize: 17
                          ),
                        ),
                        margin: EdgeInsets.only(top: 5),
                      )
                    ],
                  )
              )
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              Text("Knowledge")
            ],
          ),
          backgroundColor: HexColor("#074F78"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: (){}),
          ],
        ),
        body: tiketKnowledgeList(),
      ),
    );
  }
}
