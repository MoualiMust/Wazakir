import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/models/tasks.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/tasksProvider.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/screens/menu.dart';
import 'package:wazakir/services/firestoreService.dart';
import 'package:wazakir/size_config.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wazakir/widgets/active_project_card.dart';
import 'package:wazakir/widgets/barMenu.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/popUpConfirm.dart';
import 'package:wazakir/widgets/topContainer.dart';
import 'package:wazakir/widgets/top_container.dart';

import 'menu/azkar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Users _user;
  List<Tasks> tasksDone = [];
  List<Tasks> tasksNotDone = [];
  bool chargement = true;

  void getData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getUser()
        .then((value) {
      _user = value;
    });
    await FireStoreService()
        .deleteScoreUser(_user.id, _user.score, _user.scoreTotale, _user.date);
    
    await FireStoreService().deleteScoreTask();
    await FireStoreService().taskDone(context);
    tasksDone = Provider.of<TaskProvider>(context, listen: false).tasksDone;
    tasksNotDone =
        Provider.of<TaskProvider>(context, listen: false).tasksNotDone;
    await Provider.of<UserProvider>(context, listen: false)
        .getUser()
        .then((value) {
      _user = value;
    });
    setState(() {
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
    return chargement
        ? Chargement()
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              bottomNavigationBar: BarMenu(
                  LightColors.kRed, Colors.white, Colors.white, Colors.white),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    ProfilContainer(_user.nom, _user.score),
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
                                  // InkWell(
                                  //   onTap: () {
                                  //     var date = DateTime.now();
                                  //     var day = DateTime(date.year, date.month, date.day + 1);
                                  //     print(day);
                                  //   },
                                  //   child: ActiveProjectsCard(
                                  //     cardColor: LightColors.kBlue,
                                  //     loadingPercent: 1,
                                  //     title: 'ذِكْرِ اللَّهِ',
                                  //     subtitle:
                                  //         'الَّذِينَ آمَنُواْ وَتَطْمَئِنُّ قُلُوبُهُم بِذِكْرِ اللَّهِ أَلاَ بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ',
                                  //   ),
                                  // ),
                                  // Divider(
                                  //   height: 2,
                                  // ),
                                  subheading('الأعمال المتبقية'),
                                  for (int i = 0; i < tasksNotDone.length; i++)
                                    InkWell(
                                      onTap: () {
                                        int lenghtTask = tasksDone.length +
                                            tasksNotDone.length;
                                        popUpConfirm(
                                            context,
                                            tasksNotDone[i].id,
                                            _user.id,
                                            _user.score,
                                            tasksNotDone[i].nmbrUser,
                                            tasksNotDone[i].score,
                                            lenghtTask);
                                      },
                                      child: ActiveProjectsCard(
                                        cardColor: LightColors.kRed,
                                        loadingPercent: 0,
                                        title: tasksNotDone[i].nom,
                                        subtitle: tasksNotDone[i].description,
                                        //heith: 110,
                                      ),
                                    ),
                                  SizedBox(
                                    height: heightSize(context, 1),
                                  ),
                                  Divider(
                                    height: 2,
                                  ),
                                  SizedBox(
                                    height: heightSize(context, 1),
                                  ),
                                  subheading('الأعمال التي قمت بها'),
                                  for (int i = 0; i < tasksDone.length; i++)
                                    ActiveProjectsCard(
                                      cardColor: LightColors.kGreen,
                                      loadingPercent: 1,
                                      title: tasksDone[i].nom,
                                      subtitle: tasksDone[i].description,
                                      //heith: 110,
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
