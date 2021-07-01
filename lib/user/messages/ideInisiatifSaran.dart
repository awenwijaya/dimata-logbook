import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ideInisiatifSaranPage extends StatefulWidget {
  const ideInisiatifSaranPage({Key key}) : super(key: key);

  @override
  _ideInisiatifSaranPageState createState() => _ideInisiatifSaranPageState();
}

class _ideInisiatifSaranPageState extends State<ideInisiatifSaranPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       appBar: AppBar(
         backgroundColor: HexColor("#074F78"),
         title: Row(
           children: <Widget>[
             IconButton(
               icon: Icon(Icons.arrow_back),
               onPressed: (){Navigator.pop(context);}
             ),
             Text("Ide Inisiatif Saran")
           ],
         )
       ),
      ),
    );
  }
}
