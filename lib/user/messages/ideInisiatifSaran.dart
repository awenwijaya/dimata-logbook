import 'dart:convert';

import 'package:dimata_logbook/API/models/tickets.dart';
import 'package:dimata_logbook/user/chatsPengguna/followUpDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class ideInisiatifSaranPage extends StatefulWidget {
  const ideInisiatifSaranPage({Key key}) : super(key: key);

  @override
  _ideInisiatifSaranPageState createState() => _ideInisiatifSaranPageState();
}

class _ideInisiatifSaranPageState extends State<ideInisiatifSaranPage> {
  var apiURLListIdeInisiatifSaran = "http://192.168.43.149:8080/api/dashboard/status-report/my-tiket/ide";

  Future<Tickets> functionListIdeInisiatifSaran() async {
    var body = jsonEncode({
      "reportByUserId" : loginPage.userId
    });
    return http.post(Uri.parse(apiURLListIdeInisiatifSaran),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final tiketIdeInisiatifSaran = ticketsFromJson(body);
        return tiketIdeInisiatifSaran;
      } else {
        final body = response.body;
        final error = ticketsFromJson(body);
        return error;
      }
    });
  }

  Widget tiketIdeInisiatifSaran() {
    return FutureBuilder<Tickets>(
      future: functionListIdeInisiatifSaran(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          if(data.status == 'false') {
            return Text("No Tickets");
          } else {
            final tiketData = data.payload;
            return ListView.builder(
              itemCount: tiketData.length,
              itemBuilder: (context, index) {
                final ideTiket = tiketData[index];
                return TextButton(
                  onPressed: (){
                    setState(() {
                      followUpDetailPage.ticketNumber = ideTiket.logNumber.toString();
                      followUpDetailPage.ticketStatusId = ideTiket.status.toString();
                      followUpDetailPage.ticketDetail = ideTiket.logDesc.toString();
                      followUpDetailPage.logReportId = ideTiket.logReportId;
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
                                      ideTiket.logNumber.toString(),
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
                                  ideTiket.reportDate.toString(),
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
                            ideTiket.logDesc.toString(),
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
         backgroundColor: HexColor("#074F78"),
         title: Row(
           children: <Widget>[
             IconButton(
               icon: Icon(Icons.arrow_back),
               onPressed: (){Navigator.pop(context);}
             ),
             Text("Ide Inisiatif Saran")
           ],
         )
       ),
        body: tiketIdeInisiatifSaran(),
      ),
    );
  }
}
