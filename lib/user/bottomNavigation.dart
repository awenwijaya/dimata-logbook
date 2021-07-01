import 'package:dimata_logbook/user/companyTickets.dart';
import 'package:dimata_logbook/user/homeUser.dart';
import 'package:dimata_logbook/user/profileUser/profileUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'chatsPengguna/messagePengguna.dart';

class bottomNavigation extends StatefulWidget {
  const bottomNavigation({Key key}) : super(key: key);

  @override
  _bottomNavigationState createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  int _currentIndex = 0;
  final tabs = [
    homePengguna(),
    companyTicketsPage(),
    messagePengguna(),
    profilePengguna()
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
                CupertinoIcons.house_alt_fill, color: HexColor("#074F78")
              ),
              title: Text(
                'Company Tickets',  style: TextStyle(color: Colors.black)
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
