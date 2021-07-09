import 'package:dimata_logbook/API/APIService.dart';
import 'package:dimata_logbook/API/models/picUser.dart';
import 'package:dimata_logbook/superAdmin/homeSuperAdmin.dart';
import 'package:dimata_logbook/superAdmin/managements/adminManagement/addAdmin.dart';
import 'package:dimata_logbook/superAdmin/managements/adminManagement/adminDetails.dart';
import 'package:dimata_logbook/superAdmin/notifications/notificationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class adminManagementPage extends StatefulWidget {
  const adminManagementPage({Key key}) : super(key: key);

  @override
  _adminManagementPageState createState() => _adminManagementPageState();
}

class _adminManagementPageState extends State<adminManagementPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Admin Management"),
          centerTitle: true,
          backgroundColor: HexColor("#074F78"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: (){
                Navigator.push(context, PageTransition(child: notificationPageSuperAdmin(), type: PageTransitionType.bottomToTop));
              },
            )
          ],
        ),
        drawer: sideMenuSuperAdmin(),
        body: FutureBuilder<PicUser>(
          future: GetAllAdmins().getAllAdmins(),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if(snapshot.hasData) {
              final adminData = data.payload;
              return ListView.builder(
                itemCount: adminData.length,
                itemBuilder: (context, index) {
                  final adminDataList = adminData[index];
                  return TextButton(
                    onPressed: (){
                      setState(() {
                        adminDetailPage.userId = adminDataList.userId;
                        adminDetailPage.loginId = adminDataList.loginId;
                        adminDetailPage.fullName = adminDataList.fullName;
                        adminDetailPage.companyId = adminDataList.companyId;
                        adminDetailPage.employeeId = adminDataList.employeeId;
                        adminDetailPage.password = adminDataList.password;
                        adminDetailPage.email = adminDataList.email;
                      });
                      Navigator.of(context).push(PageTransition(child: adminDetailPage(), type: PageTransitionType.bottomToTop));
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              CupertinoIcons.person_circle_fill,
                              color: HexColor("#074F78"),
                              size: 17,
                            ),
                          ),
                          Container(
                            child: Text(
                              adminDataList.fullName,
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
                    ),
                  );
                },
              );
            } else {
              return Center(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                              CupertinoIcons.xmark_circle_fill,
                              color: HexColor("#074F78"),
                              size: 20
                          ),
                          Container(
                            child: Text(
                              "No Admins",
                              style: TextStyle(
                                  fontSize: 17
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      )
                  )
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(PageTransition(child: addAdminPage(), type: PageTransitionType.bottomToTop));
          },
          child: Icon(Icons.add),
          backgroundColor: HexColor("#074F78"),
          tooltip: "Add Admin",
        ),
      )
    );
  }
}
