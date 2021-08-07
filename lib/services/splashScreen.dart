import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wazakir/auth/controllAuth.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/onbording.dart';


bool initScreen;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool("seen");
    await prefs.setBool("seen", true);

    if (seen == false || seen == null) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 600),
              child: Onbording()));
    } else {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 600),
              child: Passerelle()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chargement();
  }
}
