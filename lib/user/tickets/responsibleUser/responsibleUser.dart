import 'package:dimata_logbook/API/models/pengguna.dart';
import 'package:dimata_logbook/API/models/picUser.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/API/APIService.dart';
import 'package:dimata_logbook/user/tickets/addTicket.dart';
import 'package:flutter/cupertino.dart';

class responsibleUser extends StatefulWidget {
  const responsibleUser({Key key}) : super(key: key);

  @override
  _responsibleUserState createState() => _responsibleUserState();
}

class _responsibleUserState extends State<responsibleUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Row(
            children: <Widget>[
              new IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){Navigator.push(context, PageTransition(child: addTicketPage(), type: PageTransitionType.topToBottom));}
              ),
              new Text(
                "Select Responsible User",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          )
        ),
        body: FutureBuilder<PicUser>(
          future: GetAllPicUser().getPICUsers(),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if(snapshot.hasData) {
              final picUserData = data.payload;
              return ListView.builder(
                itemCount: picUserData.length,
                itemBuilder: (context, index) {
                  final picUserDataList = picUserData[index];
                  return TextButton(
                    onPressed: (){
                      setState(() {
                        addTicketPage.responsibleUserIdSelected = picUserDataList.userId;
                        addTicketPage.responsibleUserNameSelected = picUserDataList.fullName;
                      });
                      Navigator.push(context, PageTransition(child: addTicketPage(), type: PageTransitionType.topToBottom));
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              child: Icon(
                                  CupertinoIcons.person_alt_circle_fill,
                                  color: HexColor("#074F78"),
                                  size: 17
                              ),
                          ),
                          Container(
                            child: Text(
                              picUserDataList.fullName,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(left: 10),
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    )
                  );
                }
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      )
    );
  }
}
