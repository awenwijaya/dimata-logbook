import 'package:dimata_logbook/admin/homeAdmin.dart';
import 'package:dimata_logbook/admin/messages/ideInisiatifSaran.dart';
import 'package:dimata_logbook/admin/messages/infoListChat.dart';
import 'package:dimata_logbook/admin/messages/knowledgeListChat.dart';
import 'package:dimata_logbook/admin/notification/notificationPage.dart';
import 'package:dimata_logbook/admin/chatsAdmin/followUpAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class messageAdmin extends StatefulWidget {
  const messageAdmin({Key key}) : super(key: key);

  @override
  _messageAdminState createState() => _messageAdminState();
}

class _messageAdminState extends State<messageAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Text("Messages"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: (){
                Navigator.push(context, PageTransition(child: notificationPageAdmin(), type: PageTransitionType.bottomToTop));
              }
            )
          ],
        ),
        drawer: sideMenuAdmin(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: ideInisiatifSaranPage(), type: PageTransitionType.bottomToTop));
                  },
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(CupertinoIcons.lightbulb_fill, size: 20),
                        margin: EdgeInsets.only(top: 40, left: 15),
                      ),
                      Container(
                        child: Text("Ide-Inisiatif-Saran", style: TextStyle(fontSize: 20)),
                        margin: EdgeInsets.only(top: 40, left: 20),
                      )
                    ]
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: knowledgeAdminPage(), type: PageTransitionType.bottomToTop));
                  },
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(CupertinoIcons.doc_text, size: 20),
                        margin: EdgeInsets.only(top: 30, left: 15),
                      ),
                      Container(
                        child: Text("Knowledge", style: TextStyle(fontSize: 20)),
                        margin: EdgeInsets.only(top: 30, left: 20),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  color: Colors.transparent,
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: infoAdminPage(), type: PageTransitionType.bottomToTop));
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(CupertinoIcons.info_circle, size: 20),
                        margin: EdgeInsets.only(top: 30, left: 15),
                      ),
                      Container(
                        child: Text("Info", style: TextStyle(fontSize: 20)),
                        margin: EdgeInsets.only(top: 30, left: 20)
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: Icon(CupertinoIcons.info),
              tooltip: "Informations",
              onPressed: (){},
              backgroundColor: HexColor("#074F78"),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              child: Icon(CupertinoIcons.person_alt),
              tooltip: "Follow Up",
              onPressed: (){
                Navigator.push(context, PageTransition(child: followUpAdminPage(), type: PageTransitionType.bottomToTop));
              },
              backgroundColor: HexColor("#074F78"),
            )
          ],
        ),
      )
    );
  }
}
