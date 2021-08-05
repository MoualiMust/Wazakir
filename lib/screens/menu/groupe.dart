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

class Groupe extends StatefulWidget {
  @override
  _GroupeState createState() => _GroupeState();
}

class _GroupeState extends State<Groupe> {
  Users _user;
  bool chargement = true;
  List<Users> _users = [];

  String dateUser(String date) {
    var today = DateTime.now();
    String day = (today.year).toString() +
        '-' +
        (today.month).toString() +
        '-' +
        (today.day).toString();
    if (day.compareTo(date) > 0)
      return date;
    else
      return day;
  }

  void getData() async {
    _users.clear();
    await Provider.of<UserProvider>(context, listen: false)
        .getUser()
        .then((value) {
      _user = value;
    });
    await getAllUsers(_user.groupeId).then((value) => _users = value);
    setState(() {
      chargement = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return chargement
        ? Chargement()
        : Scaffold(
            bottomNavigationBar:
                BarMenu(Colors.white, Colors.white, Colors.white, Colors.white),
            backgroundColor: LightColors.kLightYellow,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  ProfilContainer(_user.nom, _user.score),
                  SizedBox(
                    height: heightSize(context, 2),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: <Widget>[
                          for (int i = 0; i < _users.length; i++)
                            ActiveProjectsCard(
                              cardColor: _users[i].score < 50
                                  ? LightColors.kRed
                                  : LightColors.kGreen,
                              loadingPercent:
                                  (double.parse((_users[i].score).toString())) *
                                              0.01 <
                                          1
                                      ? (double.parse(
                                              (_users[i].score).toString())) *
                                          0.01
                                      : 1,
                              title: _users[i].nom,
                              subtitle:
                                  '${dateUser(_users[i].date)}',
                            ),
                        ],
                      ),
                    )),
                  )
                ],
              ),
            ),
          );
  }
}
