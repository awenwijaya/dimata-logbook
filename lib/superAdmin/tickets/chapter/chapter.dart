import 'package:dimata_logbook/API/APIService.dart';
import 'package:dimata_logbook/API/models/chapter.dart';
import 'package:dimata_logbook/superAdmin/tickets/addTicket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class chapterSuperAdmin extends StatefulWidget {
  const chapterSuperAdmin({Key key}) : super(key: key);

  @override
  _chapterSuperAdminState createState() => _chapterSuperAdminState();
}

class _chapterSuperAdminState extends State<chapterSuperAdmin> {
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
                    onPressed: (){Navigator.push(context, PageTransition(child: addTicketSuperAdminPage(), type: PageTransitionType.topToBottom));},
                  ),
                  new Text(
                      "Chapter"
                  )
                ],
              ),
            ),
            body: FutureBuilder<List<Chapter>>(
                future: GetAllChapter().getChapter(),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if(snapshot.hasData) {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final chapterData = data[index];
                          return TextButton(
                            onPressed: (){
                              setState(() {
                                addTicketSuperAdminPage.chapterNameSelected = chapterData.pasalUmum;
                                addTicketSuperAdminPage.chapterIdSelected = chapterData.pasalUmumId;
                              });
                              Navigator.push(context, PageTransition(child: addTicketSuperAdminPage(), type: PageTransitionType.topToBottom));
                            },
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: Row(
                                    children: <Widget>[
                                      Container(
                                          child: Icon(
                                              CupertinoIcons.book,
                                              size: 17,
                                              color: HexColor("#074F78")
                                          )
                                      ),
                                      Container(
                                          child: Text(
                                              chapterData.pasalUmum,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black
                                              )
                                          ),
                                          margin: EdgeInsets.only(left: 10)
                                      )
                                    ]
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15)
                            ),
                          );
                        }
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator()
                    );
                  }
                }
            )
        )
    );
  }
}
