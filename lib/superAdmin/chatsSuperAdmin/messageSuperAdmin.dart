import 'package:dimata_logbook/superAdmin/chatsSuperAdmin/followUpSuperAdmin.dart';
import 'package:dimata_logbook/superAdmin/homeSuperAdmin.dart';
import 'package:dimata_logbook/superAdmin/messages/ideInisiatifSaran.dart';
import 'package:dimata_logbook/superAdmin/messages/infoListChat.dart';
import 'package:dimata_logbook/superAdmin/messages/knowledgeListChat.dart';
import 'package:dimata_logbook/superAdmin/notifications/notificationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class messageSuperAdmin extends StatefulWidget {
  const messageSuperAdmin({Key key}) : super(key: key);

  @override
  _messageSuperAdminState createState() => _messageSuperAdminState();
}

class _messageSuperAdminState extends State<messageSuperAdmin> {
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
                Navigator.push(context, PageTransition(child: notificationPageSuperAdmin(), type: PageTransitionType.bottomToTop));
              },
            )
          ],
        ),
        drawer: sideMenuSuperAdmin(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).push(PageTransition(child: ideInisiatifSaranSuperAdminPage(), type: PageTransitionType.bottomToTop));
                    },
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Container(
                            child: Icon(CupertinoIcons.lightbulb_fill, size: 20,),
                            margin: EdgeInsets.only(top: 40, left: 15)
                        ),
                        Container(
                            child: Text("Ide-Inisiatif-Saran", style: TextStyle(
                                fontSize: 20),
                            ),
                            margin: EdgeInsets.only(top: 40, left: 20)
                        )
                      ],
                    ),
                  )
              ),
              Container(
                  child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).push(PageTransition(child: knowledgeSuperAdminPage(), type: PageTransitionType.bottomToTop));
                      },
                      color: Colors.transparent,
                      child: Row(
                          children: <Widget>[
                            Container(
                                child: Icon(CupertinoIcons.doc_text, size: 20),
                                margin: EdgeInsets.only(top: 30, left: 15)
                            ),
                            Container(
                                child: Text("Knowledge", style: TextStyle(
                                    fontSize: 20
                                )),
                                margin: EdgeInsets.only(top: 30, left: 20)
                            )
                          ]
                      )
                  )
              ),
              Container(
                  child: FlatButton(
                      color: Colors.transparent,
                      onPressed: (){
                        Navigator.of(context).push(PageTransition(child: infoSuperAdminPage(), type: PageTransitionType.bottomToTop));
                      },
                      child: Row(
                          children: <Widget>[
                            Container(
                                child: Icon(CupertinoIcons.info_circle, size: 20),
                                margin: EdgeInsets.only(top: 30, left: 15)
                            ),
                            Container(
                                child: Text("Info", style: TextStyle(
                                    fontSize: 20
                                )),
                                margin: EdgeInsets.only(top: 30, left: 20)
                            )
                          ]
                      )
                  )
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
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: infoSuperAdminPage(), type: PageTransitionType.bottomToTop));
                  },
                  backgroundColor: HexColor("#074F78")
              ),
              SizedBox(
                  height: 10
              ),
              FloatingActionButton(
                  child: Icon(CupertinoIcons.person_alt),
                  tooltip: "Follow Up",
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: followUpSuperAdminPage(), type: PageTransitionType.bottomToTop));
                  },
                  backgroundColor: HexColor("#074F78")
              )
            ]
        ),
      ),
    );
  }
}
