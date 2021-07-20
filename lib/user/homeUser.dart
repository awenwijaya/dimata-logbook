import 'dart:convert';

import 'package:dimata_logbook/API/models/tickets.dart';
import 'package:dimata_logbook/loginRegistrasi.dart';
import 'package:dimata_logbook/main.dart';
import 'package:dimata_logbook/shared/loading.dart';
import 'package:dimata_logbook/user/tickets/addTicket.dart';
import 'package:dimata_logbook/user/tickets/ticketDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notifications/notificationPage.dart';
import 'package:http/http.dart' as http;

class homePengguna extends StatefulWidget {
  const homePengguna({Key key}) : super(key: key);

  @override
  _homePenggunaState createState() => _homePenggunaState();
}

class _homePenggunaState extends State<homePengguna> {
  //untuk yang dikotak
  int jumlahProblem = 0;
  int jumlahRequest = 0;
  int jumlahSupport = 0;
  int jumlahBugs = 0;
  var apiURLBugs = "http://192.168.18.10:8080/api/dashboard/count-status-my-tiket/bugs";
  var apiURLSupport = "http://192.168.18.10:8080/api/dashboard/count-status-my-tiket/support";
  var apiURLProblems = "http://192.168.18.10:8080/api/dashboard/count-status-my-tiket/problem";
  var apiURLRequest = "http://192.168.18.10:8080/api/dashboard/count-status-my-tiket/request";
  bool Loading = false;
  var apiURLDetailTiket = "http://192.168.18.10:8080/api/dashboard/detail/tiket";
  var tiketListWaitingForSupport = "http://192.168.18.10:8080/api/dashboard/status/my-tiket/0";
  var tiketListInProgress = "http://192.168.18.10:8080/api/dashboard/status/my-tiket/1";
  var tiketListDone = "http://192.168.18.10:8080/api/dashboard/status/my-tiket/2";

  setBugs() {
    var bodyCount = jsonEncode({
      'reportByUserId' : loginPage.userId
    });
    http.post(Uri.parse(apiURLBugs),
      headers : {"Content-Type" : "application/json"},
      body : bodyCount
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          jumlahBugs = parsedJson;
        });
      }
    });
  }

  setSupport() {
    var body = jsonEncode({
      'reportByUserId' : loginPage.userId
    });
    http.post(Uri.parse(apiURLSupport),
      headers : {"Content-Type" : "application/json"},
      body : body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          jumlahSupport = parsedJson;
        });
      }
    });
  }

  setProblems() {
    var body = jsonEncode({
      'reportByUserid' : loginPage.userId
    });
    http.post(Uri.parse(apiURLProblems),
      headers : {"Content-Type" : "application/json"},
      body : body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          jumlahProblem = parsedJson;
        });
      }
    });
  }

  setRequest() {
    var body = jsonEncode({
      'reportByUserId' : loginPage.userId
    });
    http.post(Uri.parse(apiURLRequest),
      headers : {"Content-Type" : "application/json"},
      body : body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          jumlahRequest = parsedJson;
        });
      }
    });
  }

  countTickets() {
    setBugs();
    setSupport();
    setProblems();
    setRequest();
  }

  Future<Tickets> functionListWaitingForSupport() async {
    var body = jsonEncode({
      "reportByUserId": loginPage.userId
    });
    return http.post(Uri.parse(tiketListWaitingForSupport),
        headers: {"Content-Type": "application/json"},
        body: body
    ).then((http.Response response) {
      if (response.statusCode == 200) {
        final body = response.body;
        final tiketWaitingForSupportData = ticketsFromJson(body);
        return tiketWaitingForSupportData;
      } else {
        final body = response.body;
        final error = ticketsFromJson(body);
        return error;
      }
    });
  }

  Future<Tickets> functionListInProgress() async {
    var body = jsonEncode({
      "reportByUserId" : loginPage.userId
    });
    return http.post(Uri.parse(tiketListInProgress),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final tiketInProgressData = ticketsFromJson(body);
        return tiketInProgressData;
      } else {
        final body = response.body;
        final error = ticketsFromJson(body);
        return error;
      }
    });
  }

  Future<Tickets> functionListDone() async {
    var body = jsonEncode({
      "reportByUserId" : loginPage.userId
    });
    return http.post(Uri.parse(tiketListDone),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final tiketDoneData = ticketsFromJson(body);
        return tiketDoneData;
      } else {
        final body = response.body;
        final error = ticketsFromJson(body);
        return error;
      }
    });
  }

   Widget tiketWaitingForSupport() {
    return FutureBuilder<Tickets>(
      future: functionListWaitingForSupport(),
      builder:(context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          if(data.status == 'false') {
            return Text("No Tickets");
          } else {
            final tiketData = data.payload;
            return ListView.builder(
                itemCount: tiketData.length,
                itemBuilder: (context, index) {
                  final waitingForSupportTiket = tiketData[index];
                  return TextButton(
                    onPressed: (){
                      setState(() {
                        var body = jsonEncode({
                          'logNumber' : waitingForSupportTiket.logNumber
                        });
                        http.post(Uri.parse(apiURLDetailTiket),
                            headers: {"Content-Type" : "application/json"},
                            body : body
                        ).then((http.Response response) {
                          var data = response.statusCode;
                          if(data == 200) {
                            var jsonBody = json.decode(response.body);
                            setState(() {
                              ticketDetailPage.reportedByUserId = jsonBody['reportByUserId'].toString();
                              ticketDetailPage.followUpByUserId = jsonBody['picUserId'].toString();
                              ticketDetailPage.responsiblePersonUserId = jsonBody['picUserId'].toString();
                              ticketDetailPage.reportDate = jsonBody['reportDate'].toString();
                              ticketDetailPage.reportType = jsonBody['statusRpt'].toString();
                              ticketDetailPage.tiketDetail = jsonBody['logDesc'].toString();
                              ticketDetailPage.logReportId = jsonBody['logReportId'];
                              ticketDetailPage.reportedBy = "null";
                              ticketDetailPage.followUpBy = "null";
                              ticketDetailPage.responsiblePerson = "null";
                            });
                            Navigator.push(context, PageTransition(child: ticketDetailPage(), type: PageTransitionType.bottomToTop));
                          }
                        });
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Stack(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                        Icons.brightness_1,
                                        color: HexColor("#074F78"),
                                        size: 10
                                    ),
                                    Container(
                                        child: Text(
                                            waitingForSupportTiket.statusRpt.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: HexColor("#074F78"),
                                                fontStyle: FontStyle.italic
                                            )
                                        ),
                                        margin: EdgeInsets.only(left: 5)
                                    )
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    waitingForSupportTiket.reportDate.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic
                                    ),
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 10, left: 10)
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              waitingForSupportTiket.logNumber.toString(),
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            margin: EdgeInsets.only(top: 10, left: 10)
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              waitingForSupportTiket.logDesc.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.black26, width: 1))
                            )
                        )
                      ],
                    ),
                  );
                }
            );
          }
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
                          "No Tickets",
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
      });
  }

  Widget tiketInProgressList() {
    return FutureBuilder<Tickets>(
      future: functionListInProgress(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData){
          if(data.status == 'false') {
            return Text("No Tickets");
          } else {
            final tiketData = data.payload;
            return ListView.builder(
                itemCount: tiketData.length,
                itemBuilder: (context, index) {
                  final inProgressTiket = tiketData[index];
                  return TextButton(
                    onPressed: (){
                      setState(() {
                        var body = jsonEncode({
                          'logNumber' : inProgressTiket.logNumber
                        });
                        http.post(Uri.parse(apiURLDetailTiket),
                            headers : {"Content-Type" : "application/json"},
                            body : body
                        ).then((http.Response response) {
                          var data = response.statusCode;
                          if(data == 200) {
                            var jsonBody = json.decode(response.body);
                            setState(() {
                              ticketDetailPage.reportedByUserId = jsonBody['reportByUserId'].toString();
                              ticketDetailPage.followUpByUserId = jsonBody['picUserId'].toString();
                              ticketDetailPage.responsiblePersonUserId = jsonBody['picUserId'].toString();
                              ticketDetailPage.reportDate = jsonBody['reportDate'].toString();
                              ticketDetailPage.reportType = jsonBody['statusRpt'].toString();
                              ticketDetailPage.tiketDetail = jsonBody['logDesc'].toString();
                              ticketDetailPage.logReportId = jsonBody['logReportId'];
                            });
                            Navigator.push(context, PageTransition(child: ticketDetailPage(), type: PageTransitionType.bottomToTop));
                          }
                        });
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Stack(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                        Icons.brightness_1,
                                        color: HexColor("#074F78"),
                                        size: 10
                                    ),
                                    Container(
                                        child: Text(
                                            inProgressTiket.statusRpt.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: HexColor("#074F78"),
                                                fontStyle: FontStyle.italic
                                            )
                                        ),
                                        margin: EdgeInsets.only(left: 5)
                                    )
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                      inProgressTiket.reportDate.toString(),
                                      style: TextStyle(color: Colors.black54,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic)
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 10, left: 10)
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                inProgressTiket.logNumber.toString(),
                                style: TextStyle(color: Colors.black, fontSize: 15)
                            ),
                            margin: EdgeInsets.only(top: 10, left: 10)
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            inProgressTiket.logDesc.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.black26, width: 1))
                          ),
                        )
                      ],
                    ),
                  );
                }
            );
          }
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
                          "No Tickets",
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
      }
    );
  }

  Widget tiketDone() {
    return FutureBuilder<Tickets>(
      future: functionListDone(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          if(data.status == false) {
            return Text("No Tickets");
          } else {
            final tiketData = data.payload;
            return ListView.builder(
                itemCount: tiketData.length,
                itemBuilder: (context, index) {
                  final tiketDone = tiketData[index];
                  return TextButton(
                    onPressed: (){
                      setState(() {
                        var body = jsonEncode({
                          'logNumber' : tiketDone.logNumber
                        });
                        http.post(Uri.parse(apiURLDetailTiket),
                            headers: {"Content-Type" : "application/json"},
                            body : body
                        ).then((http.Response response) {
                          var data = response.statusCode;
                          if(data == 200) {
                            var jsonBody = json.decode(response.body);
                            setState(() {
                              ticketDetailPage.reportedByUserId = jsonBody['reportByUserId'].toString();
                              ticketDetailPage.followUpByUserId = jsonBody['picUserId'].toString();
                              ticketDetailPage.responsiblePersonUserId = jsonBody['picUserId'].toString();
                              ticketDetailPage.reportDate = jsonBody['reportDate'].toString();
                              ticketDetailPage.reportType = jsonBody['statusRpt'].toString();
                              ticketDetailPage.tiketDetail = jsonBody['logDesc'].toString();
                              ticketDetailPage.logReportId = jsonBody['logReportId'];
                            });
                            Navigator.push(context, PageTransition(child: ticketDetailPage(), type: PageTransitionType.bottomToTop));
                          }
                        });
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Stack(
                                children: <Widget>[
                                  Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.brightness_1,
                                          color: HexColor("#074F78"),
                                          size: 10,
                                        ),
                                        Container(
                                            child: Text(
                                              tiketDone.statusRpt.toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: HexColor("#074F78"),
                                                  fontStyle: FontStyle.italic
                                              ),
                                            ),
                                            margin: EdgeInsets.only(left: 5)
                                        )
                                      ]
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      tiketDone.reportDate.toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  )
                                ]
                            ),
                            margin: EdgeInsets.only(top: 10, left: 10)
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(tiketDone.logNumber.toString(), style: TextStyle(color: Colors.black, fontSize: 15)),
                            margin: EdgeInsets.only(top: 10, left: 10)
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                tiketDone.logDesc.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black, fontSize: 15)
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
                }
            );
          }
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
                        "No Tickets",
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
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    countTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#074F78"),
          title: Text("My Tickets"),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
                icon: Icon(Icons.notifications),
                onPressed: (){
                  Navigator.push(context, PageTransition(child: notificationPage(), type: PageTransitionType.bottomToTop));
                }
            )
          ],
        ),
        drawer: sideMenuUser(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Positioned(
                child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search ticket/title",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: (){},
                      )
                    )
                  ),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 25)
                ),
              ),
              new Positioned(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "My Tickets",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    )
                  ),
                    margin: EdgeInsets.only(top: 20, left: 25)
                )
              ),
              new Positioned(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        child: Column(
                          children: <Widget>[
                            new Container(
                              child: FlatButton(
                                onPressed: () {},
                                minWidth: 60,
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                                ),
                                child: Text(
                                  '$jumlahSupport',
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              ),
                              margin: EdgeInsets.only(top: 25),
                            ),
                            new Container(
                                child: Text(
                                    "Support",
                                    style: TextStyle(
                                        fontSize: 16
                                    )
                                ),
                                margin: EdgeInsets.only(top: 15)
                            )
                          ],
                        )
                      ),
                      new Positioned(
                          child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                      child: FlatButton(
                                        onPressed: () {},
                                        minWidth: 60,
                                        color: Colors.yellow,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(7)
                                        ),
                                        child: Text(
                                          '$jumlahBugs',
                                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                                      ),
                                      margin: EdgeInsets.only(top: 25)
                                    ),
                                    new Container(
                                        child: Text(
                                            "Bugs",
                                            style: TextStyle(
                                                fontSize: 16
                                            )
                                        ),
                                        margin: EdgeInsets.only(top: 15)
                                    )
                                  ],
                              ),
                              margin: EdgeInsets.only(left: 20)
                          )
                      ),
                      new Positioned(
                          child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    child: FlatButton(
                                      onPressed: (){},
                                      minWidth: 60,
                                      color: Colors.deepOrangeAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: Text(
                                        '$jumlahProblem',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                                    ),
                                      margin: EdgeInsets.only(top: 25)
                                  ),
                                  new Container(
                                      child: Text(
                                          "Problems",
                                          style: TextStyle(
                                              fontSize: 16
                                          )
                                      ),
                                      margin: EdgeInsets.only(top: 15)
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 20)
                          )
                      ),
                      new Positioned(
                          child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    child: FlatButton(
                                      onPressed: () {},
                                      minWidth: 60,
                                      color: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: Text(
                                        '$jumlahRequest',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                                    ),
                                    margin: EdgeInsets.only(top: 25)
                                  ),
                                  new Container(
                                      child: Text(
                                          "Request",
                                          style: TextStyle(
                                              fontSize: 16
                                          )
                                      ),
                                      margin: EdgeInsets.only(top: 15)
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 20)
                          )
                      )
                    ]
                  )
                )
              ),
              new Positioned(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black26,
                                  width: 7.0
                              )
                          )
                      ),
                      margin: EdgeInsets.only(top: 15)
                  )
              ),
              new Positioned(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text('Ticket Status', textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        margin: EdgeInsets.only(left: 25, top: 20)
                      ),
                      DefaultTabController(
                        length: 3,
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                labelColor: HexColor("#074F78"),
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(text: 'Waiting for Support'),
                                  Tab(text: 'In Progress'),
                                  Tab(text: 'Done')
                                ]
                              )
                            ),
                            Container(
                              height: 400,
                              decoration: BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                              ),
                              child: TabBarView(
                                children: <Widget>[
                                  Container(
                                      child: Center(
                                        child: tiketWaitingForSupport(),
                                      ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: tiketInProgressList(),
                                    )
                                  ),
                                  Container(
                                      child: Center(
                                        child: tiketDone()
                                      )
                                  ),
                                ]
                              )
                            )
                          ]
                        )
                      )
                    ]
                  )
                )
              )
            ]
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, PageTransition(child: addTicketPage(), type: PageTransitionType.bottomToTop));
          },
          child: const Icon(Icons.add),
          backgroundColor: HexColor("#074F78"),
          tooltip: "Add Ticket",
        ),
      )
    );
  }
}

class sideMenuUser extends StatefulWidget {
  const sideMenuUser({Key key}) : super(key: key);

  @override
  _sideMenuUserState createState() => _sideMenuUserState();
}

class _sideMenuUserState extends State<sideMenuUser> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            child: Image(
              image: AssetImage("images/logo_dimata.png"),
              width: 50,
              height: 50,
            ),
            margin: EdgeInsets.only(top: 20),
          ),
          Divider(color: Colors.black26),
          ListTile(
            title: Text('My Tickets', style: TextStyle(fontSize: 18)),
            leading: Icon(CupertinoIcons.doc_on_doc_fill),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => homePengguna()));}
          ),
          ListTile(
            title: Text('Guidelines', style: TextStyle(fontSize: 18)),
            leading: Icon(CupertinoIcons.book),
            onTap: () {},
          ),
          ListTile(
            title: Text('Logout', style: TextStyle(fontSize: 18)),
            leading: Icon(Icons.logout),
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Logout?'),
                    content: Text("Are you sure want to logout?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () async {
                          final SharedPreferences sharedpref = await SharedPreferences.getInstance();
                          sharedpref.remove('status');
                          sharedpref.remove('userId');
                          sharedpref.remove('userType');
                          sharedpref.remove('companyId');
                          sharedpref.remove('userName');
                          sharedpref.remove('userPassword');
                          Navigator.of(context).push(PageTransition(child: MyApp(), type: PageTransitionType.fade));
                        },
                      ),
                      TextButton(
                        child: Text('No'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                }
              );
            },
          )
        ]
      )
    );
  }
}