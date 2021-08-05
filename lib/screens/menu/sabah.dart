import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/services/getAllUsers.dart';
import 'package:wazakir/size_config.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/active_project_card.dart';
import 'package:wazakir/widgets/barMenu.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/topContainer.dart';
import 'package:wazakir/widgets/top_container.dart';

class Sabah extends StatefulWidget {
  @override
  _SabahState createState() => _SabahState();
}

class _SabahState extends State<Sabah> {
 
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
                  TopContainer( width: MediaQuery.of(context).size.width, height: 100, child: text('أذكار الصباح'),)
                ],
              ),
            ),
          );
  }
}
