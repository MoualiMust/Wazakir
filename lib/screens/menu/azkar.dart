import 'package:flutter/material.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/barMenu.dart';
import 'package:wazakir/widgets/top_container.dart';

class Azkar extends StatefulWidget {
  @override
  _AzkarState createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {
 
  Widget text(String text){
    return Center(child: Text(text,style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 26.0
    ),));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            bottomNavigationBar:
                BarMenu(Colors.white, Colors.white, Colors.white, Colors.white),
            backgroundColor: LightColors.kLightYellow,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  TopContainer( width: MediaQuery.of(context).size.width, height: 100, child: text('أذكار'),)
                ],
              ),
            ),
          );
  }
}
