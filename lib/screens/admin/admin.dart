import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/models/tasks.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/screens/admin/addNewTask.dart';
import 'package:wazakir/screens/admin/detail.dart';
import 'package:wazakir/services/addUserTasks.dart';
import 'package:wazakir/services/firestoreService.dart';
import 'package:wazakir/size_config.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/active_project_card.dart';
import 'package:wazakir/widgets/barMenu.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/topContainer.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Users _user;
  List<Tasks> _tasks = [];
  bool chargement = true;

  bool isAdmin = false;
  final TextEditingController _groupeController = TextEditingController();

  void getData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getUser()
        .then((value) {
      _user = value;
    });
    await FireStoreService()
        .getTasks(_user.groupeId)
        .then((value) => _tasks = value);
    setState(() {
      chargement = false;
      _groupeController.text = _user.groupeId;
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
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              bottomNavigationBar: BarMenu(
                  Colors.white, Colors.white, Colors.white, Colors.white),
              backgroundColor: LightColors.kLightYellow,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ProfilContainer(_user.nom, _user.score),
                    SizedBox(
                      height: heightSize(context, 2),
                    ),
                    Text(
                      'أنت فقط من يمكنه التعديل على المجموعة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'أي تعديل تقوم به سيظهر عند كل أعضاء هذه المجموعة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: heightSize(context, 1),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: heightSize(context, 0.5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () async {
                              await FlutterShare.share(
                                  title: 'وَذَكِّرْ',
                                  text:
                                      ' قم بتحميل تطبيق وذكر وإنضم الى مجموعة أصدقائك بإستعمال هذا الرمز  ${_groupeController.text} ',
                                  linkUrl:
                                      'https://play.google.com/store/apps/details?id=com.lborjdigital.wazakir',
                                  chooserTitle: 'تطبيق وذكر');
                            },
                            child: Icon(
                              Icons.share,
                              color: Colors.green,
                            )),
                        SizedBox(
                          width: widthSize(context, 3),
                        ),
                        Text(
                          'رمز المجموعة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _groupeController,
                      decoration: InputDecoration(border: InputBorder.none),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 600),
                                  child: AddNewTask()));
                        },
                        height: heightSize(context, 7),
                        color: LightColors.kBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Text(
                          'إضافة عمل جديد',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              for (int i = 0; i < _tasks.length; i++)
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.bottomToTop,
                                            duration:
                                                Duration(milliseconds: 600),
                                            child: DetailAdmin(_tasks[i].id)));
                                  },
                                  child: ActiveProjectsCard(
                                    cardColor: (double.parse(
                                                (_tasks[i].scoreTotale)
                                                    .toString())) <
                                            50
                                        ? LightColors.kRed
                                        : LightColors.kGreen,
                                    loadingPercent: (double.parse(
                                                    (_tasks[i].scoreTotale)
                                                        .toString())) *
                                                0.01 <
                                            1
                                        ? (double.parse((_tasks[i].scoreTotale)
                                                .toString())) *
                                            0.01
                                        : 1,
                                    title: _tasks[i].nom,
                                    subtitle: _tasks[i].description,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
