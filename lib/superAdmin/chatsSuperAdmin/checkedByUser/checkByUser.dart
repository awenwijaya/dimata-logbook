import 'package:dimata_logbook/superAdmin/chatsSuperAdmin/addFollowUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/API/APIService.dart';
import 'package:dimata_logbook/API/models/picUser.dart';

class checkByUser extends StatefulWidget {
  const checkByUser({Key key}) : super(key: key);

  @override
  _checkByUserState createState() => _checkByUserState();
}

class _checkByUserState extends State<checkByUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){Navigator.of(context).push(PageTransition(child: addFollowUpSuperAdminPage(), type: PageTransitionType.topToBottom));},
              ),
              Text("Select Checked By User")
            ],
          ),
          backgroundColor: HexColor("#074F78"),
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
                        addFollowUpSuperAdminPage.chkByUserId = picUserDataList.userId;
                        addFollowUpSuperAdminPage.chkByUserName = picUserDataList.fullName;
                      });
                      Navigator.of(context).push(PageTransition(child: addFollowUpSuperAdminPage(), type: PageTransitionType.topToBottom));
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
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      )
    );
  }
}
