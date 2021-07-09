import 'package:dimata_logbook/superAdmin/managements/adminManagement/addAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/API/APIService.dart';
import 'package:dimata_logbook/API/models/company.dart';

class companyListPage extends StatefulWidget {
  const companyListPage({Key key}) : super(key: key);

  @override
  _companyListPageState createState() => _companyListPageState();
}

class _companyListPageState extends State<companyListPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Row(
            children: <Widget>[
              IconButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: addAdminPage(), type: PageTransitionType.topToBottom));
                  },
                  icon: Icon(Icons.arrow_back)
              ),
              Text("Select Company")
            ],
          ),
        ),
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
                        addAdminPage.companyName = companyData.company.toString();
                        addAdminPage.companyId = companyData.companyId.toString();
                      });
                      Navigator.of(context).push(PageTransition(child: addAdminPage(), type: PageTransitionType.bottomToTop));
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
      ),
    );
  }
}
