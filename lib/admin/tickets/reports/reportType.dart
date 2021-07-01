import 'package:dimata_logbook/API/APIService.dart';
import 'package:dimata_logbook/API/models/kategoriTiket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dimata_logbook/admin/tickets/addTicket.dart';

class reportCategoriesAdmin extends StatefulWidget {
  const reportCategoriesAdmin({Key key}) : super(key: key);

  @override
  _reportCategoriesAdminState createState() => _reportCategoriesAdminState();
}

class _reportCategoriesAdminState extends State<reportCategoriesAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: HexColor("#074F78"),
                title: Row(
                  children: <Widget>[
                    new IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: (){Navigator.push(context, PageTransition(child: addTicketPageAdmin(), type: PageTransitionType.topToBottom));}
                    ),
                    new Text(
                        "Select Report Type",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        )
                    )
                  ],
                )
            ),
            body: FutureBuilder<List<KategoriTiket>>(
                future: GetAllTiketKategori().getKategoriTiket(),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if(snapshot.hasData) {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final kategoriTiketData = data[index];
                          return TextButton(
                              onPressed: (){
                                setState(() {
                                  addTicketPageAdmin.reportIdSelected = kategoriTiketData.rptTypeId;
                                  addTicketPageAdmin.reportNameSelected = kategoriTiketData.typeName;
                                  addTicketPageAdmin.reportTypeSelected = kategoriTiketData.statusRpt;
                                });
                                Navigator.push(context, PageTransition(child: addTicketPageAdmin(), type: PageTransitionType.topToBottom));
                              },
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Icon(
                                        CupertinoIcons.gear,
                                        size: 17,
                                        color: HexColor("#074F78"),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        kategoriTiketData.typeName,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15)
                              )
                          );
                        }
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
            )
        )
    );
  }
}

