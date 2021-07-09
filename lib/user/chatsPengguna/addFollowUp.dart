import 'dart:convert';

import 'package:dimata_logbook/user/bottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:dimata_logbook/shared/loading.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/user/chatsPengguna/followUpDetail.dart';

class addFollowUpPage extends StatefulWidget {
  const addFollowUpPage({Key key}) : super(key: key);

  @override
  _addFollowUpPageState createState() => _addFollowUpPageState();
}

class _addFollowUpPageState extends State<addFollowUpPage> {
  final controllerFollowUpNote = TextEditingController();
  String dropdownStatusValue = 'In Progress';
  String holderStatusValue = '';
  var statusId;
  bool Loading = false;
  var apiURLAddFollowUp = "http://192.168.43.149:8080/api/log-follow-up/add";

  List<String> statusValueList = [
    'In Progress',
    'Done'
  ];

  void getDropdownStatusItem() {
    setState(() {
      holderStatusValue = dropdownStatusValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Loading ? loading() : MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: HexColor("#074F78"),
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              Text("Add Follow Up")
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        child: Text(
                          "Add New Follow Up",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        child: Text(
                          "* = required",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17
                          ),
                        ),
                        margin: EdgeInsets.only(left: 80)
                      )
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20, left: 20)
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Follow Up Note *",
                        style: TextStyle(fontSize: 15)
                      ),
                      margin: EdgeInsets.only(top: 5, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerFollowUpNote,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder()
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Follow Up Status *",
                        style: TextStyle(fontSize: 15),
                      ),
                      margin: EdgeInsets.only(top: 5, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
                        child: DropdownButton<String>(
                          value: dropdownStatusValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String data) {
                            setState(() {
                              dropdownStatusValue = data;
                            });
                          },
                          items: statusValueList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value)
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 5)
              ),
              Container(
                child: RaisedButton(
                  onPressed: () async{
                    if(controllerFollowUpNote.text == '') {
                      Fluttertoast.showToast(
                        msg: "Follow up note fields are empty. Please fill the follow up note fields to continue",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        fontSize: 14
                      );
                    } else {
                      setState(() {
                        Loading = true;
                      });
                      if(dropdownStatusValue == 'In Progress') {
                        setState(() {
                          statusId = "1";
                        });
                      } else if(dropdownStatusValue == 'Done') {
                        setState(() {
                          statusId = "2";
                        });
                      }
                      var body = jsonEncode({
                        "flwNote" : controllerFollowUpNote.text,
                        "logReportId": followUpDetailPage.logReportId,
                        "flwUpByUserId" : loginPage.userId,
                        "flwUpStatus" : statusId,
                        "chkByUserId" : loginPage.userId
                      });
                      http.post(Uri.parse(apiURLAddFollowUp),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                            Navigator.of(context).push(PageTransition(child: bottomNavigation(), type: PageTransitionType.topToBottom));
                          });
                        }
                      });
                    }
                  },
                  color: HexColor("#074F78"),
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white
                        ),
                      ),
                      Container(
                        child: Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                          ),
                        ),
                        margin: EdgeInsets.only(left: 15)
                      )
                    ],
                  ),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 140),
                margin: EdgeInsets.only(top: 25),
              )
            ],
          )
        ),
      ),
    );
  }
}
