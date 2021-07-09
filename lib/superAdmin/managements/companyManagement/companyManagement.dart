import 'package:dimata_logbook/API/APIService.dart';
import 'package:dimata_logbook/API/models/company.dart';
import 'package:dimata_logbook/superAdmin/homeSuperAdmin.dart';
import 'package:dimata_logbook/superAdmin/managements/companyManagement/addCompany.dart';
import 'package:dimata_logbook/superAdmin/managements/companyManagement/companyDetail.dart';
import 'package:dimata_logbook/superAdmin/notifications/notificationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class companyManagementPage extends StatefulWidget {
  const companyManagementPage({Key key}) : super(key: key);

  @override
  _companyManagementPageState createState() => _companyManagementPageState();
}

class _companyManagementPageState extends State<companyManagementPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Company Management"),
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
        body: FutureBuilder<List<Company>>(
          future: GetAllCompanies().getAllCompanies(),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final companyData = data[index];
                  return TextButton(
                    onPressed: (){
                      setState(() {
                        companyDetailPage.companyCode = companyData.companyCode.toString();
                        companyDetailPage.companyName = companyData.company.toString();
                        companyDetailPage.companyId = companyData.companyId.toString();
                        companyDetailPage.companyDescription = companyData.description.toString();
                      });
                      Navigator.of(context).push(PageTransition(child: companyDetailPage(), type: PageTransitionType.bottomToTop));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.brightness_1,
                                color: HexColor("#074F78"),
                                size: 10,
                              ),
                              Container(
                                child: Text(
                                  companyData.companyCode.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: HexColor("#074F78"),
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                                  margin: EdgeInsets.only(left: 5)
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            companyData.company,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                            margin: EdgeInsets.only(top: 10, left: 10)
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            companyData.description.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15
                            ),
                          ),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.black26, width: 1))
                          ),
                        )
                      ],
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
                              "No Company",
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
            Navigator.of(context).push(PageTransition(child: addCompanyPage(), type: PageTransitionType.topToBottom));
          },
          child: Icon(Icons.add),
          backgroundColor: HexColor("#074F78"),
          tooltip: "Add Company",
        )
      )
    );
  }
}
