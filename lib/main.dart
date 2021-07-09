import 'dart:async';

import 'package:dimata_logbook/admin/bottomNavigation.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:dimata_logbook/superAdmin/bottomNavigation.dart';
import 'package:dimata_logbook/user/bottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
      home: new splashScreen()
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
}

class splashScreen extends StatefulWidget {
  const splashScreen({Key key}) : super(key: key);

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  final pageDelay = 3;
  String status;
  var userStatus;
  var userType;
  var companyId;
  var userName;
  var userPassword;
  var userId;
  Future getUserStatusInfo() async {
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    userStatus = sharedpref.getString('status');
    userType = sharedpref.getInt('userType');
    companyId = sharedpref.getInt('companyId');
    userName = sharedpref.getString('userName');
    userPassword = sharedpref.getString('userPassword');
    userId = sharedpref.getInt('userId');
    setState(() {
      status = userStatus;
    });
  }

  loadWidget() async {
    var duration = Duration(seconds: pageDelay);
    getUserStatusInfo().whenComplete(() async{
      print(status);
      if(status == 'login') {
        setState(() {
          loginPage.userId = userId;
          loginPage.userType = userType;
          loginPage.userName = userName;
          loginPage.userPassword = userPassword;
          loginPage.companyId = companyId;
        });
        if(loginPage.userType == 0) {
          return Timer(duration, navigatorUserHomePage);
        } else if(loginPage.userType == 1) {
          return Timer(duration, navigatorAdminHomePage);
        } else if(loginPage.userType == 2) {
          return Timer(duration, navigatorSuperAdminHomePage);
        }
      } else {
        return Timer(duration, navigator);
      }
    });

  }

  void navigatorUserHomePage() {
    Navigator.push(context, PageTransition(child: bottomNavigation(), type: PageTransitionType.fade));
  }

  void navigatorAdminHomePage() {
    Navigator.push(context, PageTransition(child: bottomNavigationAdmin(), type: PageTransitionType.fade));
  }

  void navigatorSuperAdminHomePage() {
    Navigator.push(context, PageTransition(child: bottomNavigationSuperAdmin(), type: PageTransitionType.fade));
  }

  void navigator() {
    Navigator.push(context, PageTransition(child: MyApp(), type: PageTransitionType.fade));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadWidget();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Image(
            image: AssetImage('images/logo_logbook.png'),
            height: 300,
            width: 300,
          ),
        )
      )
    );
  }
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Positioned(child: LayoutBuilder(
                    builder: (_, constraints) => Image(
                        width: constraints.maxWidth,
                        image: AssetImage('images/welcome_bg.png')
                    ),
                  )),
                  new Positioned(child: Align(
                    alignment: Alignment.topCenter,
                      child: Container(
                          child: Image(
                            image: AssetImage('images/logo_logbook.png'),
                            width: 250,
                            height: 250,
                          ),
                        margin: EdgeInsets.only(top: 250),
                      )
                  ))
                ],
              ),
              new Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: loginPage(),
                                  type: PageTransitionType.rightToLeftWithFade)
                          );
                        },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: HexColor("#074F78"),
                      elevation: 5.0,
                    ),
                    new TextButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Dimata Logbook Account'),
                                content: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text("In order for you to get a Dimata Logbook account, you can contact your organization or contact the Dimata Team by calling the following number:"),
                                      Text("Hotline: +6281 812 377 10011"),
                                      Text("Phone: +62361 482431, 499029")
                                    ],
                                  ),
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
                        },
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              new Positioned(child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Stack(
                  children: <Widget>[
                    new Container(
                      child: Text(
                        "A product by Dimata IT Solutions",
                        style: TextStyle(fontSize: 12),
                      ),
                      alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(top: 65),
                    ),
                    new Container(
                      child: Image.asset(
                        'images/logo_dimata.png',
                        height: 120,
                          width: 120,
                      ),
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(top: 60)
                    )
                  ],
                )
              ))
            ],
          )
        )
      )
    );
  }
}