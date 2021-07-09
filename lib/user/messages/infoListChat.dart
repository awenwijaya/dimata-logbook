import 'dart:convert';

import 'package:dimata_logbook/API/models/tickets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/user/chatsPengguna/followUpDetail.dart';

class infoPenggunaPage extends StatefulWidget {
  const infoPenggunaPage({Key key}) : super(key: key);

  @override
  _infoPenggunaPageState createState() => _infoPenggunaPageState();
}

class _infoPenggunaPageState extends State<infoPenggunaPage> {
  var apiURLListInfo = "http://192.168.43.149:8080/api/dashboard/status-report/my-tiket/info";

  Future<Tickets> functionListInfo() async {
    var body = jsonEncode({
      "reportByUserId" : loginPage.userId
    });
    return http.post(Uri.parse(apiURLListInfo),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final tiketInfo = ticketsFromJson(body);
        return tiketInfo;
      } else {
        final body = response.body;
        final error = ticketsFromJson(body);
        return error;
      }
    });
  }

  Widget tiketInfoList() {
    return FutureBuilder<Tickets>(
      future: functionListInfo(),
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
                final infoTiket = tiketData[index];
                return TextButton(
                  onPressed: (){
                    setState(() {
                      followUpDetailPage.ticketNumber = infoTiket.logNumber.toString();
                      followUpDetailPage.ticketStatusId = infoTiket.status.toString();
                      followUpDetailPage.ticketDetail = infoTiket.logDesc.toString();
                      followUpDetailPage.logReportId = infoTiket.logReportId;
                    });
                    Navigator.of(context).push(PageTransition(child: followUpDetailPage(), type: PageTransitionType.rightToLeft));
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
                                      infoTiket.logNumber.toString(),
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
                                  infoTiket.reportDate.toString(),
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
                            infoTiket.logDesc.toString(),
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
                  onPressed: (){Navigator.pop(context);}
              ),
              Text("Info")
            ],
          ),
            backgroundColor: HexColor("#074F78"),
            actions: <Widget>[
              new IconButton(
                icon: Icon(Icons.search),
                onPressed: (){},
              )
            ]
        ),
        body: tiketInfoList(),
      ),
    );
  }
}
