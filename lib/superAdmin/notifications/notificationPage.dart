import 'dart:convert';

import 'package:dimata_logbook/API/models/Notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:dimata_logbook/loginRegistrasi.dart';

class notificationPageSuperAdmin extends StatefulWidget {
  const notificationPageSuperAdmin({Key key}) : super(key: key);

  @override
  _notificationPageSuperAdminState createState() => _notificationPageSuperAdminState();
}

class _notificationPageSuperAdminState extends State<notificationPageSuperAdmin> {
  var apiURLNotifications = "http://192.168.43.149:8080/api/log-notification/get";

  Future<Notifications> functionListNotification() async {
    var body = jsonEncode({
      "userId" : loginPage.userId
    });
    return http.post(Uri.parse(apiURLNotifications),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final notificationData = notificationsFromJson(body);
        return notificationData;
      } else {
        final body = response.body;
        final error = notificationsFromJson(body);
        return error;
      }
    });
  }

  Widget notificationListPage() {
    return FutureBuilder<Notifications>(
        future: functionListNotification(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            if (data.status == false) {
              return Text("No Notifications");
            } else {
              final notificationData = data.payload;
              return ListView.builder(
                itemCount: notificationData.length,
                itemBuilder: (context, index) {
                  final notificationListTickets = notificationData[index];
                  return TextButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            CupertinoIcons.person_circle_fill,
                            color: HexColor("#074F78"),
                            size: 20,
                          ),
                          margin: EdgeInsets.only(right: 10, left: 15),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  notificationListTickets.logNotification
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  notificationListTickets.date.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14
                                  ),
                                ),
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              backgroundColor: HexColor("#074F78"),
              title: Row(
                  children: <Widget>[
                    Positioned(child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: (){Navigator.pop(context);},
                    )),
                    Positioned(child: Text("Notifications"))
                  ]
              )
          ),
          body: notificationListPage(),
        )
    );
  }
}
