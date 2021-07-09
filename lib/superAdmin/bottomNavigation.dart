import 'package:dimata_logbook/superAdmin/chatsSuperAdmin/messageSuperAdmin.dart';
import 'package:dimata_logbook/superAdmin/homeSuperAdmin.dart';
import 'package:dimata_logbook/superAdmin/profileSuperAdmin/profileSuperAdmin.dart';
import 'package:dimata_logbook/superAdmin/reports/reportPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class bottomNavigationSuperAdmin extends StatefulWidget {
  const bottomNavigationSuperAdmin({Key key}) : super(key: key);

  @override
  _bottomNavigationSuperAdminState createState() => _bottomNavigationSuperAdminState();
}

class _bottomNavigationSuperAdminState extends State<bottomNavigationSuperAdmin> {
  int _currentIndex = 0;
  final tabs = [
    homeSuperAdmin(),
    messageSuperAdmin(),
    reportPageSuperAdmin(),
    profileSuperAdmin()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                        CupertinoIcons.book_fill, color: HexColor("#074F78")
                    ),
                    title: Text(
                        'My Tickets',  style: TextStyle(color: Colors.black)
                    )
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        CupertinoIcons.ellipses_bubble_fill, color: HexColor("#074F78")
                    ),
                    title: Text(
                        'Messages',  style: TextStyle(color: Colors.black)
                    )
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        CupertinoIcons.chart_bar_alt_fill, color: HexColor("#074F78")
                    ),
                    title: Text(
                        'Reports',  style: TextStyle(color: Colors.black)
                    )
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_alt, color: HexColor("#074F78")),
                    title: Text('Profile',  style: TextStyle(color: Colors.black))
                )
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              }
          ),
        )
    );
  }
}
