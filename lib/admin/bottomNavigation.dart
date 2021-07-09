import 'package:dimata_logbook/admin/chatsAdmin/messageAdmin.dart';
import 'package:dimata_logbook/admin/companyTickets.dart';
import 'package:dimata_logbook/admin/homeAdmin.dart';
import 'package:dimata_logbook/admin/profileAdmin/profileAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class bottomNavigationAdmin extends StatefulWidget {
  const bottomNavigationAdmin({Key key}) : super(key: key);

  @override
  _bottomNavigationAdminState createState() => _bottomNavigationAdminState();
}

class _bottomNavigationAdminState extends State<bottomNavigationAdmin> {

  int currentIndex = 0;
  final tabs = [
    homeAdmin(),
    companyTicketAdminPage(),
    messageAdmin(),
    profileAdmin()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: tabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book_fill, color: HexColor("#074F78")),
              title: Text('My Tickets', style: TextStyle(color: Colors.black)),

            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_alt_fill, color: HexColor("#074F78")),
              title: Text('Company Tickets', style: TextStyle(color: Colors.black)),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.ellipses_bubble_fill, color: HexColor("#074F78")),
              title: Text('Messages', style: TextStyle(color: Colors.black)),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_alt, color: HexColor("#074F78")),
              title: Text('Profile', style: TextStyle(color: Colors.black))
            )
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          }
        ),
      )
    );
  }
}
