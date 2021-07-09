import 'package:dimata_logbook/admin/userManagement/editUser.dart';
import 'package:dimata_logbook/admin/userManagement/userManagementAdmin.dart';
import 'package:dimata_logbook/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class userDetailPage extends StatefulWidget {
  static var userId;
  static var loginId;
  static var fullName;
  static var companyId;
  static var employeeId;
  static var password;
  static var email;
  const userDetailPage({Key key}) : super(key: key);

  @override
  _userDetailPageState createState() => _userDetailPageState();
}

class _userDetailPageState extends State<userDetailPage> {
  bool Loading = false;
  var apiURLDelete = "http://192.168.43.149:8080/api/user/delete";

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
                    Navigator.of(context).push(PageTransition(child: userManagementAdminPage(), type: PageTransitionType.topToBottom));
                  },
                  icon: Icon(Icons.arrow_back)
              ),
              Text("User Details")
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(CupertinoIcons.pencil),
              onPressed: (){
                Navigator.of(context).push(PageTransition(child: editUserPage(), type: PageTransitionType.bottomToTop));
              },
              tooltip: "Edit User",
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Full Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    userDetailPage.fullName.toString(),
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 15, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Phone Number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    userDetailPage.loginId.toString(),
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 15, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40, left: 30)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    userDetailPage.email.toString(),
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                  margin: EdgeInsets.only(top: 15, left: 30)
              ),
              Container(
                child: RaisedButton(
                  onPressed: (){},
                  color: HexColor("#a81111"),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Text(
                                "Delete User",
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
                      ],
                    ),
                  ),
                ),
                  margin: EdgeInsets.only(top: 30, left: 40, right: 40)
              )
            ],
          ),
        ),
      ),
    );
  }
}
