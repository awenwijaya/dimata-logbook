import 'dart:convert';

import 'package:dimata_logbook/shared/loading.dart';
import 'package:dimata_logbook/superAdmin/managements/companyManagement/companyManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class addCompanyPage extends StatefulWidget {
  const addCompanyPage({Key key}) : super(key: key);

  @override
  _addCompanyPageState createState() => _addCompanyPageState();
}

class _addCompanyPageState extends State<addCompanyPage> {
  final controllerCompanyName = TextEditingController();
  final controllerCompanyDescription = TextEditingController();
  var apiURL = "http://192.168.43.149:8080/api/super-admin/company/add";
  bool Loading =  false;

  @override
  Widget build(BuildContext context) {
    return Loading ? loading() : MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Row(
            children: <Widget>[
              IconButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => companyManagementPage()));
                },
                icon: Icon(Icons.arrow_back)
              ),
              Text("Add Company")
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
                          "Add New Company",
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
                      ),
                    )
                  ],
                ),
                  margin: EdgeInsets.only(top: 20, left: 20)
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Company Name *",
                        style: TextStyle(fontSize: 15),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 8
                        ),
                        child: TextField(
                          controller: controllerCompanyName,
                          decoration: InputDecoration(
                            hintText: "Company Name"
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Company Description *",
                        style: TextStyle(
                          fontSize: 15
                        ),
                      ),
                        margin: EdgeInsets.only(top: 5, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 8
                        ),
                        child: TextField(
                          controller: controllerCompanyDescription,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Company Description"
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: Container(
                  child: RaisedButton(
                    onPressed: () async {
                      if(controllerCompanyName.text == '' || controllerCompanyDescription.text == '') {
                        Fluttertoast.showToast(
                            msg: "There are some fields are empty. Please fill the empty field before continue",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            fontSize: 14
                        );
                      } else {
                        setState(() {
                          Loading = true;
                        });
                        var body = jsonEncode({
                          "company" : controllerCompanyName.text,
                          "description" : controllerCompanyDescription.text
                        });
                        http.post(Uri.parse(apiURL),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                        ).then((http.Response response) {
                          var responseValue = response.statusCode;
                          if(responseValue == 200) {
                            setState(() {
                              Loading = false;
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => companyManagementPage()));
                            });
                          } else {
                            setState(() {
                              Loading = false;
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Company Already Exists!'),
                                    content: Container(
                                      child: Text("Company you tried to add is already exists! Please try add another company data"),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: (){Navigator.of(context).pop();},
                                      )
                                    ],
                                  );
                                }
                              );
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
                              Icons.add,
                              color: Colors.white
                          ),
                        ),
                        Container(
                          child: Text(
                            "Save",
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
                    margin: EdgeInsets.only(top: 25)
                ),
              )
            ],
          ),
        )
      )
    );
  }
}