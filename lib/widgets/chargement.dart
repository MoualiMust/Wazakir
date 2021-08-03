import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wazakir/theme/colors/light_colors.dart';

import '../size_config.dart';

class Chargement extends StatefulWidget {
  @override
  _ChargementState createState() => _ChargementState();
}

class _ChargementState extends State<Chargement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kDarkYellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 50.0),
            child: Column(
              children: <Widget>[
                Text('Wazakir',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700
                ),),
                SizedBox(height: heightSize(context, 10)),
                
                SpinKitChasingDots(
                  color: Colors.white,
                  size: 50.0,
                ),
              ],
            )

          )
          
        ],
      ),
    );
  }
}
