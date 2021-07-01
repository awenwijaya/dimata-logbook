import 'dart:convert';

import 'package:dimata_logbook/admin/bottomNavigation.dart';
import 'package:dimata_logbook/shared/loading.dart';
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
                                          new TextButton(
                                            onPressed: (){
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: registerPage(),
                                                      type: PageTransitionType.rightToLeftWithFade)
                                              );
                                            },
                                            child: Text(
                                                "Don't have account? Register now",
                                                style: TextStyle(
                                                    color: Colors.black
                                                )
                                            ),
                                          )
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

class registerPage extends StatefulWidget {
  const registerPage({Key key}) : super(key: key);

  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  String dropdownJabatanValue = 'Staff';
  String holderJabatan = '';
  bool Loading = false;
  var apiURL = "http://192.168.18.10:8080/api/user";

  List<String> jabatanList = [
    'Staff',
    'Manager',
    'Supervisor',
    'Owner'
  ];

  final controllerID = TextEditingController();
  final controllerFullName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerCompanyCode = TextEditingController();

  void getDropdownJabatanItem() {
    setState(() {
      holderJabatan = dropdownJabatanValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Loading ? loading() : MaterialApp(
      home: Scaffold(
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
                                          "Register",
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
                                          "Or register with",
                                          style: TextStyle(
                                              fontSize: 15
                                          )
                                      ),
                                      alignment: Alignment.bottomRight,
                                      margin: EdgeInsets.only(top: 170, right: 20)
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
                              padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
                              child: TextFormField(
                                controller: controllerFullName,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Name'
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
                              child: TextFormField(
                                controller: controllerEmail,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
                              child: TextFormField(
                                controller: controllerID,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Phone Number',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
                              child: TextFormField(
                                controller: controllerCompanyCode,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Company Code',
                                ),
                              ),
                            ),
                            Center(
                                child: Container(
                                    child: FlatButton(
                                        color: Colors.transparent,
                                        onPressed: (){
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            // false = user must tap button, true = tap outside dialog
                                            builder: (BuildContext dialogContext) {
                                              return AlertDialog(
                                                title: Text('Company Code'),
                                                content: Container(
                                                    child: Column(
                                                        children: <Widget>[
                                                          new Text("Company code is the code used to register the company identity registered with Dimata."),
                                                          new Text("Get your company code from the Dimata team by calling the following number"),
                                                          new Text("Hotline: +6281 812 377 10011"),
                                                          new Text("Phone: +62361 482431, 499029")
                                                        ]
                                                    )
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('OK, got it!'),
                                                    onPressed: () {
                                                      Navigator.of(dialogContext)
                                                          .pop(); // Dismiss alert dialog
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          child: Text(
                                              "What is company code?",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic
                                              )
                                          ),
                                        )
                                    )
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
                              child: DropdownButton<String>(
                                value: dropdownJabatanValue,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                underline: Container(
                                  height: 2,
                                  color: Colors.black
                                ),
                                onChanged: (String data) {
                                  setState(() {
                                    dropdownJabatanValue = data;
                                  });
                                },
                                items: jabatanList.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                      child: Text(value)
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
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
                                          if(controllerID.text == '' || controllerPassword.text == '' || controllerFullName.text == '' || controllerEmail == '' || controllerCompanyCode == '') {
                                            Fluttertoast.showToast(
                                              msg: "There are some fields are empty. Please fill the empty field before continue the registration",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              fontSize: 14
                                            );
                                          } else {
                                            setState(() => Loading = true);
                                            var body = jsonEncode({
                                              'loginId' : controllerID.text,
                                              'password' : controllerPassword.text,
                                              'fullName' : controllerFullName.text,
                                              'email' : controllerEmail.text,
                                              'companyCode' : controllerCompanyCode.text
                                            });
                                            http.post(Uri.parse(apiURL),
                                              headers: {"Content-Type" : "application/json"},
                                              body: body
                                            ).then((http.Response response) {
                                              var responseValue = response.statusCode;
                                              if(responseValue == 200) {
                                                setState(() {
                                                  Loading = false;
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      child: loginPage(),
                                                      type: PageTransitionType.rightToLeftWithFade
                                                    )
                                                  );
                                                  Fluttertoast.showToast(
                                                      msg: "Register succeed! Please login to continue use this app",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      fontSize: 14
                                                  );
                                                });
                                              } else if(responseValue == 400) {
                                                setState(() {
                                                  Loading = false;
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Company Code Invalid'),
                                                        content: Text('Sorry! The company code you inserted is invalid. Please try again!'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text('OK'),
                                                            onPressed: (){
                                                              Navigator.pop(context);
                                                            },
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
                                        child: Text(
                                            "Register",
                                            style: TextStyle(
                                                color: Colors.white
                                            )
                                        ),
                                        color: HexColor("#074F78"),
                                        elevation: 5,
                                      ),
                                      new TextButton(
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: loginPage(),
                                                  type: PageTransitionType.rightToLeftWithFade)
                                          );
                                        },
                                        child: Text(
                                            "Already have an account? Login to your Account",
                                            style: TextStyle(
                                                color: Colors.black
                                            )
                                        ),
                                      )
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