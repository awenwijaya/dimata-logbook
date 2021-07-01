import 'package:dimata_logbook/API/APIService.dart';
import 'package:dimata_logbook/API/models/kategoriTiket.dart';
import 'package:dimata_logbook/user/tickets/addTicket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class reportCategories extends StatefulWidget {
  const reportCategories({Key key}) : super(key: key);

  @override
  _reportCategoriesState createState() => _reportCategoriesState();
}

class _reportCategoriesState extends State<reportCategories> {

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
                  onPressed: (){Navigator.push(context, PageTransition(child: addTicketPage(), type: PageTransitionType.topToBottom));}
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
                          addTicketPage.reportIdSelected = kategoriTiketData.rptTypeId;
                          addTicketPage.reportNameSelected = kategoriTiketData.typeName;
                          addTicketPage.reportTypeSelected = kategoriTiketData.statusRpt;
                        });
                        Navigator.push(context, PageTransition(child: addTicketPage(), type: PageTransitionType.topToBottom));
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
                            )
                          ),
                          Container(
                            child: Text(
                                kategoriTiketData.typeName,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(left: 10)
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15)
                    ),
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
