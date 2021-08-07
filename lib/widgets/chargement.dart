import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wazakir/theme/colors/light_colors.dart';

import '../size_config.dart';

class Chargement extends StatefulWidget {
  @override
  _ChargementState createState() => _ChargementState();
}

class _ChargementState extends State<Chargement> {
  final data = [
    'سبحان الله',
    'الحمد لله',
    'سبحان الله وبحمده',
    'لاحول ولاقوة الابالله',
    'حسبي الله ونعم الوكيل',
    'الله أكبر',
    'استغفر الله',
    'لا إله إلا الله'
  ];

  Random rnd = new Random();

  @override
  Widget build(BuildContext context) {
    int r = rnd.nextInt(data.length);
    return Scaffold(
      backgroundColor: LightColors.kDarkYellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'وَذَكِّرْ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 42.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: heightSize(context, 8)),
                  SpinKitChasingDots(
                    color: Colors.white,
                    size: 50.0,
                  ),
                  SizedBox(height: heightSize(context, 4)),
                  Text(
                    'ثواني الإنتظار إملأها بذكر الله',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data[r].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
