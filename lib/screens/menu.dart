import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/screens/menu/ahadith.dart';
import 'package:wazakir/screens/menu/azkar.dart';
import 'package:wazakir/screens/menu/groupe.dart';
import 'package:wazakir/screens/menu/iblagh.dart';
import 'package:wazakir/screens/menu/logOut.dart';
import 'package:wazakir/screens/menu/masaa.dart';
import 'package:wazakir/screens/menu/nawm.dart';
import 'package:wazakir/screens/menu/quitGroupe.dart';
import 'package:wazakir/screens/menu/sabah.dart';
import 'package:wazakir/size_config.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/barMenu.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/topContainer.dart';
import 'package:wazakir/widgets/top_container.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Users _user;
  bool chargement = true;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  bool isAdmin = false;

  void getData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getUser()
        .then((value) {
      _user = value;
      setState(() {
        chargement = false;
      });
    });
    await _db.collection('groupes').doc(_user.groupeId).get().then((value) {
      if (value.data()['admin'] == _user.id)
        setState(() {
          isAdmin = true;
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
    return chargement
        ? Chargement()
        : Scaffold(
            bottomNavigationBar: BarMenu(
                Colors.white, Colors.white, Colors.white, LightColors.kRed),
            backgroundColor: LightColors.kLightYellow,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  ProfilContainer(_user.nom, _user.score),
                  SizedBox(
                    height: heightSize(context, 4),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 600),
                                      child: Groupe()));
                            },
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'أعضاء المجموعة',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 3),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 600),
                                      child: Sabah()));
                            },
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'أذكار الصباح',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 3),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 600),
                                      child: Masaa()));
                            },
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'أذكار المساء',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 3),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 600),
                                      child: Nawm()));
                            },
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'أذكار النوم',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 3),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 600),
                                      child: Ahadith()));
                            },
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'أحاديث',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 3),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 600),
                                      child: Azkar()));
                            },
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'أذكار',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 3),
                          ),
                          InkWell(
                            onTap: () {
                              popUpQuiterGroupe(context, _user.groupeId);
                            },
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'خروج من المجموعة',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 3),
                          ),
                          InkWell(
                            onTap: () {
                              popUpLogOut(context);
                            },
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'تسجيل الخروج',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 3),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'نشر التطبيق',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 3),
                          ),
                          InkWell(
                            onTap: () {
                              popUpIblagh(context, _user.id);
                            },
                            child: Container(
                              height: heightSize(context, 6),
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: LightColors.kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'إبلاغ عن مشكل',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 2),
                          ),
                          isAdmin
                              ? Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        popUpIblagh(context, _user.id);
                                      },
                                      child: Container(
                                        height: heightSize(context, 6),
                                        width: MediaQuery.of(context).size.width *
                                            0.85,
                                        decoration: BoxDecoration(
                                            color: LightColors.kBlue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Center(
                                          child: Text(
                                            'Admin',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                  height: heightSize(context, 2),
                                ),
                                ],
                              )
                              : Container(),
                          Center(
                            child: Text(
                              '🤲🏻 لاتنسونا من صالح دعائكم 🙏🏻',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 1.5),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
