import 'package:dimata_logbook/user/chatsPengguna/followUpPengguna.dart';
import 'package:dimata_logbook/user/messages/ideInisiatifSaran.dart';
import 'package:dimata_logbook/user/messages/infoListChat.dart';
import 'package:dimata_logbook/user/notifications/notificationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import '../homeUser.dart';
import '../messages/knowledgeUser.dart';

class messagePengguna extends StatefulWidget {
  const messagePengguna({Key key}) : super(key: key);

  @override
  _messagePenggunaState createState() => _messagePenggunaState();
}

class _messagePenggunaState extends State<messagePengguna> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Text("Messages"),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
                icon: Icon(Icons.notifications),
                onPressed: (){
                  Navigator.push(context, PageTransition(child: notificationPage(), type: PageTransitionType.bottomToTop));
                }
            )
          ],
        ),
        drawer: sideMenuUser(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  child: FlatButton(
                    onPressed: (){
                      Navigator.push(context, PageTransition(child: ideInisiatifSaranPage(), type: PageTransitionType.bottomToTop));
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
                    Navigator.push(context, PageTransition(child: knowledgePenggunaPage(), type: PageTransitionType.bottomToTop));
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
                    Navigator.push(context, PageTransition(child: infoPenggunaPage(), type: PageTransitionType.bottomToTop));
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
              onPressed: (){},
                backgroundColor: HexColor("#074F78")
            ),
            SizedBox(
              height: 10
            ),
            FloatingActionButton(
              child: Icon(CupertinoIcons.person_alt),
              tooltip: "Follow Up",
              onPressed: (){
                Navigator.push(context, PageTransition(child: followUpPenggunaPage(), type: PageTransitionType.bottomToTop));
              },
                backgroundColor: HexColor("#074F78")
            )
          ]
        ),
      ),
    );
  }
}
