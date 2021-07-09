import 'package:dimata_logbook/superAdmin/bottomNavigation.dart';
import 'package:dimata_logbook/superAdmin/homeSuperAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';

class sendTicketBerhasilSuperAdminPage extends StatefulWidget {
  const sendTicketBerhasilSuperAdminPage({Key key}) : super(key: key);

  @override
  _sendTicketBerhasilSuperAdminPageState createState() => _sendTicketBerhasilSuperAdminPageState();
}

class _sendTicketBerhasilSuperAdminPageState extends State<sendTicketBerhasilSuperAdminPage> {
  final pageDelay = 3;

  @override
  void initState() {
    loadWidget();
  }

  loadWidget() async {
    var duration = Duration(seconds: pageDelay);
    return Timer(duration, navigator);
  }

  void navigator() {
    Navigator.push(context, PageTransition(child: homeSuperAdmin(), type: PageTransitionType.topToBottom));
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Positioned(
                    child: Container(
                      child: Image(
                        image: AssetImage('images/send_successfull.png'),
                        height: 100,
                        width: 100,
                      ),
                    )
                ),
                new Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Your ticket has been sent",
                      style: TextStyle(
                          fontSize: 20,
                          color: HexColor("#074F78"),
                          fontWeight: FontWeight.bold
                      ),
                    )
                )
              ],
            )
        )
    );
  }
}
