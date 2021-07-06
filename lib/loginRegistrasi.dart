import 'dart:convert';

import 'package:dimata_logbook/admin/bottomNavigation.dart';
import 'package:dimata_logbook/shared/loading.dart';
import 'package:dimata_logbook/superAdmin/bottomNavigation.dart';
import 'package:dimata_logbook/user/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  static var userName;
  static var userId;
  static var userType;
  static var userPassword;
  static var companyId;
  const loginPage({Key key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final controllerPhoneNumber = TextEditingController();
  final controllerPassword = TextEditingController();
  bool Loading = false;
  var apiURL = "http://192.168.18.10:8080/api/user/login";
  var userName = loginPage.userName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
          body: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    new Stack(
                        children: <Widget>[
                          new LayoutBuilder(
                            builder: (_, constraints) => Image(
                                width: constraints.maxWidth,
                                image: AssetImage('images/login_regis_bg.png')
                            ),
                          ),
                          new Align(
                              alignment: Alignment(-1.0,-1.0),
                              child: Container(
                                  child: Column(
                                      children: <Widget>[
                                        new IconButton(
                                            icon: Icon(
                                                Icons.arrow_back,
                                                size: 35,
                                                color: Colors.white
                                            ),
                                            onPressed:(){
                                              Navigator.pop(context);
                                            }
                                        ),
                                        new Container(
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 35,
                                                  color: Colors.white
                                              ),
                                            ),
                                            margin: EdgeInsets.only(left: 20, top: 10)
                                        )
                                      ]
                                  ),
                                  margin: EdgeInsets.only(top: 70, left: 25)
                              )
                          ),
                          new Container(
                            child: Container(
                                child: Column(
                                    children: <Widget>[
                                      new Container(
                                          child: Text(
                                              "Or login with",
                                              style: TextStyle(
                                                  fontSize: 15
                                              )
                                          ),
                                          alignment: Alignment.bottomRight,
                                          margin: EdgeInsets.only(top: 170, right: 25)
                                      ),
                                      new Container(
                                        child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              new Container(
                                                child: FlatButton(
                                                    color: Colors.transparent,
                                                    onPressed:(){},
                                                    child: Image.asset(
                                                        'images/google_logo.png',
                                                        height: 35,
                                                        width: 35
                                                    )
                                                ),
                                                margin: EdgeInsets.only(top: 5),
                                              ),
                                              new Container(
                                                child: FlatButton(
                                                    color: Colors.transparent,
                                                    onPressed: (){},
                                                    child: Image.asset(
                                                        'images/facebook_logo.png',
                                                        height: 35,
                                                        width: 35
                                                    )
                                                ),
                                              )
                                            ]
                                        ),
                                      )
                                    ]
                                )
                            ),
                          )
                        ]
                    ),
                    new Container(
                        child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 38, vertical: 16),
                                  child: TextFormField(
                                    controller: controllerPhoneNumber,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Phone Number',
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 38, vertical: 8),
                                    child: TextFormField(
                                      controller: controllerPassword,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Password',
                                      ),
                                      obscureText: true,
                                    )
                                ),
                                new Center(
                                  child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          new RaisedButton(
                                            onPressed: (){
                                              if(controllerPhoneNumber.text == '' || controllerPassword.text == '') {
                                                Fluttertoast.showToast(
                                                  msg: "Both phone number field or password field can't be empty! Please try again",
                                                  fontSize: 14,
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER
                                                );
                                              } else {
                                                setState(() => Loading = true);
                                                var body = jsonEncode({
                                                  'loginId' : controllerPhoneNumber.text,
                                                  'password' : controllerPassword.text
                                                });
                                                http.post(Uri.parse(apiURL),
                                                  headers : {"Content-Type" : "application/json"},
                                                  body: body
                                                ).then((http.Response response) {
                                                  var data = response.statusCode;
                                                  if(data == 500) {
                                                    setState(() {
                                                      Loading = false;
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Login Failed'),
                                                            content: Container(
                                                              child: Text('Phone number or password might be incorrect. Please try again')
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text('OK'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                }
                                                              )
                                                            ]
                                                          );
                                                        }
                                                      );
                                                    });
                                                  } else if(data == 200) {
                                                    setState(() async {
                                                      Loading = false;
                                                      var jsonData = response.body;
                                                      var parsedJson = json.decode(jsonData);
                                                      setState(() {
                                                        loginPage.userId = parsedJson['userId'];
                                                        loginPage.userType = parsedJson['employeeId'];
                                                        loginPage.userName = parsedJson['fullName'];
                                                        loginPage.userPassword = parsedJson['password'];
                                                        loginPage.companyId = parsedJson['companyId'];
                                                      });
                                                      final SharedPreferences sharedpref = await SharedPreferences.getInstance();
                                                      sharedpref.setInt('userId', loginPage.userId);
                                                      sharedpref.setInt('userType', loginPage.userType);
                                                      sharedpref.setInt('companyId', loginPage.companyId);
                                                      sharedpref.setString('userName', loginPage.userName);
                                                      sharedpref.setString('userPassword', loginPage.userPassword);
                                                      sharedpref.setString('status', 'login');
                                                      print(loginPage.companyId);
                                                      if(loginPage.userType == 0) {
                                                        Navigator.push(context, PageTransition(child: bottomNavigation(), type: PageTransitionType.bottomToTop));
                                                      } else if(loginPage.userType == 1) {
                                                        Navigator.push(context, PageTransition(child: bottomNavigationAdmin(), type: PageTransitionType.bottomToTop));
                                                      } else if(loginPage.userType == 2) {
                                                        Navigator.push(context, PageTransition(child: bottomNavigationSuperAdmin(), type: PageTransitionType.bottomToTop));
                                                      }
                                                    });
                                                  } else {
                                                    setState(() {
                                                      Loading = false;
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                                title: Text('Login Failed'),
                                                                content: Container(
                                                                    child: Text("Sorry! There might been a problem in our server. Please try again later")
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      }
                                                                  )
                                                                ]
                                                            );
                                                          }
                                                      );
                                                    });
                                                  }
                                                });
                                              }
                                            },
                                            child: Text(
                                                "Login",
                                                style: TextStyle(
                                                    color: Colors.white
                                                )
                                            ),
                                            color: HexColor("#074F78"),
                                            elevation: 5,
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.only(top: 30)
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 20)
                        )
                    ),
                  ]
              )
          )
      )
    );
  }
}