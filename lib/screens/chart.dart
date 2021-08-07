import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/models/tasks.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/services/firestoreService.dart';
import 'package:wazakir/size_config.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/active_project_card.dart';
import 'package:wazakir/widgets/barMenu.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/topContainer.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Users _user;
  List<Tasks> tasks = [];
  bool chargement = true;

  dynamic score = 0;

  String type = '';

  var color1, color2, color3;

  void getData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getUser()
        .then((value) {
      _user = value;
    });
    await FireStoreService()
        .getTasks(_user.groupeId)
        .then((value) => tasks = value);
    setState(() {
      color1 = LightColors.kBlue;
      color2 = Colors.indigo[100];
      color3 = Colors.indigo[100];
      score = _user.score;
      type = 'today';
      chargement = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
Widget subheading(String title) {
    return Center(
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
            color: LightColors.kDarkBlue,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (score > 100)
      setState(() {
        score = 100;
      });
    return chargement
        ? Chargement()
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              bottomNavigationBar: BarMenu(
                  Colors.white, LightColors.kRed, Colors.white, Colors.white),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    ProfilContainer(_user.nom, _user.score),
                    SizedBox(
                      height: heightSize(context, 2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              type = 'all';
                              color3 = LightColors.kBlue;
                              color2 = Colors.indigo[100];
                              color1 = Colors.indigo[100];
                              score =
                                  double.parse((_user.scoreTotale).toString());
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                                color: color3,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: Text(
                                'معدل الأداء',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              type = 'hier';
                              color2 = LightColors.kBlue;
                              color1 = Colors.indigo[100];
                              color3 = Colors.indigo[100];
                              score =
                                  double.parse((_user.scoreHier).toString());
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                                color: color2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: Text(
                                'الأمس',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              type = 'today';
                              color1 = LightColors.kBlue;
                              color2 = Colors.indigo[100];
                              color3 = Colors.indigo[100];
                              score = double.parse((_user.score).toString());
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                                color: color1,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: Text(
                                'اليوم',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: heightSize(context, 1),
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: heightSize(context, 1),
                                  ),
                                  
                                  ActiveProjectsCard(
                                    cardColor: score < 50
                                        ? LightColors.kRed
                                        : LightColors.kGreen,
                                    loadingPercent: (double.parse(
                                                    (score).toString())) *
                                                0.01 <
                                            1
                                        ? (double.parse((score).toString())) *
                                            0.01
                                        : 1,
                                    title: _user.nom,
                                    subtitle:
                                        '${double.parse(score.toString()).toStringAsFixed(1)} % نسبة الأداء',
                                  ),
                                  SizedBox(
                                    height: heightSize(context, 1),
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: heightSize(context, 1),
                                  ),
                                  subheading('أداء المجموعة'),
                                  for (int i = 0; i < tasks.length; i++)
                                    ActiveProjectsCard(
                                      cardColor: type == 'today'
                                          ? (double.parse((tasks[i].score)
                                                      .toString())) <
                                                  50
                                              ? LightColors.kRed
                                              : LightColors.kGreen
                                          : type == 'hier'
                                              ? (double.parse(
                                                          (tasks[i].scoreHier)
                                                              .toString())) <
                                                      50
                                                  ? LightColors.kRed
                                                  : LightColors.kGreen
                                              : (double.parse(
                                                          (tasks[i].scoreTotale)
                                                              .toString())) <
                                                      50
                                                  ? LightColors.kRed
                                                  : LightColors.kGreen,
                                      loadingPercent: type == 'today'
                                          ? (double.parse((tasks[i].score).toString())) *
                                                      0.01 <
                                                  1
                                              ? (double.parse((tasks[i].score).toString())) *
                                                  0.01
                                              : 1
                                          : type == 'hier'
                                              ? (double.parse((tasks[i].scoreHier).toString())) *
                                                          0.01 <
                                                      1
                                                  ? (double.parse(
                                                          (tasks[i].scoreHier)
                                                              .toString())) *
                                                      0.01
                                                  : 1
                                              : (double.parse((tasks[i]
                                                                  .scoreTotale)
                                                              .toString())) *
                                                          0.01 <
                                                      1
                                                  ? (double.parse(
                                                          (tasks[i].scoreTotale)
                                                              .toString())) *
                                                      0.01
                                                  : 1,
                                      title: tasks[i].nom,
                                      subtitle: tasks[i].description,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
