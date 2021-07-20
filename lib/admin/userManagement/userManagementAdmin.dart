import 'dart:convert';

import 'package:dimata_logbook/API/models/user.dart';
import 'package:dimata_logbook/admin/homeAdmin.dart';
import 'package:dimata_logbook/admin/notification/notificationPage.dart';
import 'package:dimata_logbook/admin/userManagement/addUser.dart';
import 'package:dimata_logbook/admin/userManagement/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:http/http.dart' as http;

class userManagementAdminPage extends StatefulWidget {
  const userManagementAdminPage({Key key}) : super(key: key);

  @override
  _userManagementAdminPageState createState() => _userManagementAdminPageState();
}

class _userManagementAdminPageState extends State<userManagementAdminPage> {
  var apiURL = "http://192.168.18.10:8080/api/user/list-user";

  Future<User> functionListUsers() async {
    var body = jsonEncode({
      "companyId" : loginPage.companyId
    });
    return http.post(Uri.parse(apiURL),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final userData = userFromJson(body);
        return userData;
      } else {
        final body = response.body;
        final error = userFromJson(body);
        return error;
      }
    });
  }

  Widget userList() {
    return FutureBuilder<User>(
      future: functionListUsers(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          if(data.status == 'false') {
            return Text("No Users");
          } else {
            final userData = data.payload;
            return ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                final userList = userData[index];
                return TextButton(
                  onPressed: (){
                    setState(() {
                      userDetailPage.userId = userList.userId;
                      userDetailPage.loginId = userList.loginId;
                      userDetailPage.fullName = userList.fullName;
                      userDetailPage.companyId = userList.companyId;
                      userDetailPage.employeeId = userList.employeeId;
                      userDetailPage.password = userList.password;
                      userDetailPage.email = userList.email;
                    });
                    Navigator.of(context).push(PageTransition(child: userDetailPage(), type: PageTransitionType.bottomToTop));
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            CupertinoIcons.person_alt,
                            size: 17,
                            color: HexColor("#074F78"),
                          ),
                        ),
                        Container(
                            child: Text(
                              userList.fullName,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(left: 10)
                        )
                      ],
                    ),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15)
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
                          "No User",
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
          title: Text("User Management"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: (){
                Navigator.push(context, PageTransition(child: notificationPageAdmin(), type: PageTransitionType.bottomToTop));
              },
            )
          ],
        ),
        drawer: sideMenuAdmin(),
        body: userList(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(PageTransition(child: addUserPage(), type: PageTransitionType.bottomToTop));
          },
          child: Icon(Icons.add),
          backgroundColor: HexColor("#074F78"),
          tooltip: "Add User",
        )
      )
    );
  }
}
