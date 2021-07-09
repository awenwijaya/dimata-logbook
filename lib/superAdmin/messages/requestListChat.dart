import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dimata_logbook/API/models/tickets.dart';
import 'package:http/http.dart' as http;
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/superAdmin/chatsSuperAdmin/followUpDetail.dart';

class requestListSuperAdminPage extends StatefulWidget {
  const requestListSuperAdminPage({Key key}) : super(key: key);

  @override
  _requestListSuperAdminPageState createState() => _requestListSuperAdminPageState();
}

class _requestListSuperAdminPageState extends State<requestListSuperAdminPage> {
  var apiURLListRequest = "http://192.168.43.149:8080/api/super-admin/status-report/requests";

  Future<Tickets> functionListRequest() async {
    var body = jsonEncode({
      "picUserId" : loginPage.userId
    });
    return http.post(Uri.parse(apiURLListRequest),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final tiketRequest = ticketsFromJson(body);
        return tiketRequest;
      } else {
        final body = response.body;
        final error = ticketsFromJson(body);
        return error;
      }
    });
  }

  Widget tiketRequestList() {
    return FutureBuilder<Tickets>(
      future: functionListRequest(),
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
                final requestTiket = tiketData[index];
                return TextButton(
                  onPressed: (){
                    setState(() {
                      followUpDetailSuperAdminPage.ticketNumber = requestTiket.logNumber.toString();
                      followUpDetailSuperAdminPage.ticketStatusId = requestTiket.status.toString();
                      followUpDetailSuperAdminPage.ticketDetail = requestTiket.logDesc.toString();
                      followUpDetailSuperAdminPage.logReportId = requestTiket.logReportId;
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
                                                requestTiket.logNumber.toString(),
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
                                            requestTiket.reportDate.toString(),
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
                                      requestTiket.logDesc.toString(),
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
                            )
                          ],
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
              Text("Requests")
            ],
          ),
          backgroundColor: HexColor("#074F78"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: (){}),
          ],
        ),
        body: tiketRequestList(),
      ),
    );
  }
}
