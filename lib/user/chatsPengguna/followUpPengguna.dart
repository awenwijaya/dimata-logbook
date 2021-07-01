import 'package:dimata_logbook/user/messages/bugsListChat.dart';
import 'package:dimata_logbook/user/messages/problemsListChat.dart';
import 'package:dimata_logbook/user/messages/requestListChats.dart';
import 'package:dimata_logbook/user/messages/supportListChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class followUpPenggunaPage extends StatefulWidget {
  const followUpPenggunaPage({Key key}) : super(key: key);

  @override
  _followUpPenggunaPageState createState() => _followUpPenggunaPageState();
}

class _followUpPenggunaPageState extends State<followUpPenggunaPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){Navigator.of(context).pop();}),
              Text("Follow Up")
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, PageTransition(child: supportListChatPage(), type: PageTransitionType.bottomToTop));
                  },
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(Icons.build, size: 20),
                        margin: EdgeInsets.only(top: 40, left: 15)
                      ),
                      Container(
                        child: Text("Support", style: TextStyle(fontSize: 20)),
                        margin: EdgeInsets.only(top: 40, left: 20)
                      )
                    ]
                  ),
                )
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, PageTransition(child: bugsListChatPage(), type: PageTransitionType.bottomToTop));
                  },
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(Icons.bug_report_rounded),
                        margin: EdgeInsets.only(top: 40, left: 15)
                      ),
                      Container(
                        child: Text("Bugs", style: TextStyle(fontSize: 20)),
                        margin: EdgeInsets.only(top: 40, left: 20)
                      )
                    ],
                  )
                )
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, PageTransition(child: problemsListChatPage(), type: PageTransitionType.bottomToTop));
                  },
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(CupertinoIcons.gear_alt_fill),
                        margin: EdgeInsets.only(top: 40, left: 15)
                      ),
                      new Container(
                        child: Text("Problems", style: TextStyle(fontSize: 20)),
                        margin: EdgeInsets.only(top: 40, left: 20)
                      )
                    ],
                  ),
                )
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, PageTransition(child: requestListChatPage(), type: PageTransitionType.bottomToTop));
                  },
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(CupertinoIcons.question_diamond_fill),
                        margin: EdgeInsets.only(top: 40, left: 15)
                      ),
                      Container(
                        child: Text("Requests", style: TextStyle(fontSize: 20)),
                        margin: EdgeInsets.only(top: 40, left: 20)
                      )
                    ],
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
