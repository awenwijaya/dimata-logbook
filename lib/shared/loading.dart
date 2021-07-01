import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class loading extends StatelessWidget {
  const loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: HexColor("#074F78"),
        child: Center(
            child: SpinKitCircle(
                color: Colors.white,
                size: 50.0
            )
        )
    );
  }
}
