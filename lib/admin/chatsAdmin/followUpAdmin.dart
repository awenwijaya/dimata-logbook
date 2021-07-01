import 'package:dimata_logbook/admin/messages/bugsListChat.dart';
import 'package:dimata_logbook/admin/messages/problemsListChat.dart';
import 'package:dimata_logbook/admin/messages/requestListChat.dart';
import 'package:dimata_logbook/admin/messages/supportListChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class followUpAdminPage extends StatefulWidget {
  const followUpAdminPage({Key key}) : super(key: key);

  @override
  _followUpAdminPageState createState() => _followUpAdminPageState();
}

class _followUpAdminPageState extends State<followUpAdminPage> {
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
              Text("Follow Up")
            ],
          ),
          backgroundColor: HexColor("#074F78"),
          actions: <Widget>[
            IconButton(
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
                    Navigator.of(context).push(PageTransition(child: supportListChatAdminPage(), type: PageTransitionType.bottomToTop));
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
                        margin: EdgeInsets.only(top: 40, left: 20),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: bugsListChatAdminPage(), type: PageTransitionType.bottomToTop));
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
                        margin: EdgeInsets.only(top: 40, left: 20),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: problemsListChatAdminPage(), type: PageTransitionType.bottomToTop));
                  },
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(CupertinoIcons.gear_alt_fill),
                        margin: EdgeInsets.only(top: 40, left: 15),
                      ),
                      Container(
                        child: Text("Problems", style: TextStyle(fontSize: 20)),
                        margin: EdgeInsets.only(top: 40, left: 20)
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: requestListChatAdminPage(), type: PageTransitionType.bottomToTop));
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
                        margin: EdgeInsets.only(top: 40, left: 20),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
