import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/screens/create_new_task_page.dart';
import 'package:wazakir/screens/home_page.dart';
import 'package:wazakir/services/joinGroupe.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wazakir/widgets/active_project_card.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/top_container.dart';

import '../size_config.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Users _user;
  bool chargement = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _groupeController = TextEditingController();

  bool val = true;

  String erreur = '';

  void getData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getUser()
        .then((value) {
      _user = value;
      setState(() {
        chargement = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return chargement
        ? Chargement()
        : Scaffold(
            backgroundColor: LightColors.kLightYellow,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  TopContainer(
                    height: 200,
                    width: width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                CircularPercentIndicator(
                                  radius: 90.0,
                                  lineWidth: 5.0,
                                  animation: true,
                                  percent: (_user.score) * 0.01,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: LightColors.kRed,
                                  backgroundColor: LightColors.kDarkYellow,
                                  center: CircleAvatar(
                                    backgroundColor: LightColors.kBlue,
                                    radius: 35.0,
                                    backgroundImage: AssetImage(
                                      'assets/images/avatar.png',
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        _user.nom,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: LightColors.kDarkBlue,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '${_user.score} % نسبة الأداء',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
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
                                InkWell(
                                  onTap: () {},
                                  child: ActiveProjectsCard(
                                    cardColor: LightColors.kBlue,
                                    loadingPercent: 0.4,
                                    title: 'ذِكْرِ اللَّهِ',
                                    subtitle:
                                        'الَّذِينَ آمَنُواْ وَتَطْمَئِنُّ قُلُوبُهُم بِذِكْرِ اللَّهِ أَلاَ بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ',
                                  ),
                                ),
                                SizedBox(
                                  height: heightSize(context, 4),
                                ),
                                Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              duration:
                                                  Duration(milliseconds: 600),
                                              child: CreateNewTaskPage()));
                                    },
                                    minWidth: width - 60,
                                    height: heightSize(context, 7),
                                    color: LightColors.kGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Text(
                                      'إنشاء مجموعة جديدة',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: heightSize(context, 4),
                                ),
                                val
                                    ? Center(
                                        child: MaterialButton(
                                          onPressed: () {
                                            setState(() {
                                              val = false;
                                            });
                                          },
                                          minWidth: width - 60,
                                          height: heightSize(context, 7),
                                          color: LightColors.kRed,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          child: Text(
                                            'الإلتحاق بمجموعة',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    : Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            Text(
                                              erreur,
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            TextFormField(
                                                controller: _groupeController,
                                                textAlign: TextAlign.right,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        'أدخل رمز المجموعة   '),
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'أدخل رمز المجموعة   ';
                                                  }
                                                  return null;
                                                }),
                                            SizedBox(
                                              height: heightSize(context, 3),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  setState(() {
                                                    chargement = true;
                                                  });
                                                  await joinGroupe(
                                                          _groupeController
                                                              .text)
                                                      .then((value) {
                                                    if (value == false)
                                                      setState(() {
                                                        erreur =
                                                            'groupe not exist';
                                                        chargement = false;
                                                      });
                                                    else
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type: PageTransitionType
                                                                  .bottomToTop,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      600),
                                                              child:
                                                                  HomePage()));
                                                  });
                                                }
                                              },
                                              minWidth: width - 60,
                                              height: heightSize(context, 7),
                                              color: LightColors.kRed,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              child: Text(
                                                'دخول',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
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
          );
  }
}
