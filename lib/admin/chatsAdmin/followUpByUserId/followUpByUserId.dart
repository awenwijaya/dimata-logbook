import 'package:dimata_logbook/API/models/picUser.dart';
import 'package:dimata_logbook/admin/chatsAdmin/addFollowUp.dart';
import 'package:dimata_logbook/admin/chatsAdmin/followUpDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/API/APIService.dart';

class followUpByUserIdPage extends StatefulWidget {
  const followUpByUserIdPage({Key key}) : super(key: key);

  @override
  _followUpByUserIdPageState createState() => _followUpByUserIdPageState();
}

class _followUpByUserIdPageState extends State<followUpByUserIdPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.push(context, PageTransition(child: followUpDetailAdminPage(), type: PageTransitionType.topToBottom));
                },
              ),
              Text(
                "Select Follow Up User"
              )
            ],
          ),
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
                  final penggunaData = picUserData[index];
                  return TextButton(
                    onPressed: (){
                      setState(() {
                        addFollowUpAdminPage.flwUpByUserId = penggunaData.userId;
                        addFollowUpAdminPage.flwUpByUser = penggunaData.fullName;
                      });
                      Navigator.push(context, PageTransition(child: addFollowUpAdminPage(), type: PageTransitionType.bottomToTop));
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              CupertinoIcons.person_alt,
                              size: 17,
                              color: HexColor("#074F78")
                            ),
                          ),
                          Container(
                            child: Text(
                              penggunaData.fullName,
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
        ),
      ),
    );
  }
}
