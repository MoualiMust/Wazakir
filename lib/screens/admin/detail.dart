import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:wazakir/models/tasks.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/screens/admin/admin.dart';
import 'package:wazakir/screens/admin/deleteTask.dart';
import 'package:wazakir/services/createTasks.dart';
import 'package:wazakir/services/setting.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/barMenu.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/popUpAddGroupe.dart';
import 'package:wazakir/widgets/top_container.dart';

import '../../size_config.dart';

class DetailAdmin extends StatefulWidget {
  final id;
  DetailAdmin(this.id);
  @override
  _DetailAdminState createState() => _DetailAdminState();
}

class _DetailAdminState extends State<DetailAdmin> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _descriptionController = TextEditingController();

  String done = '';
  String nom = '';
  bool chargement = true;
  Users _user;
  Tasks _task;

  getData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getUser()
        .then((value) {
      _user = value;
    });
    await getTask(_user.groupeId, widget.id).then((value) => _task = value);
    setState(() {
      _descriptionController.text = _task.description;
      nom = _task.nom;
      chargement = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  var color = Colors.green[800];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return chargement
        ? Chargement()
        : Scaffold(
            bottomNavigationBar:
                BarMenu(Colors.white, Colors.white, Colors.white, Colors.white),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TopContainer(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                      width: width,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  nom,
                                  style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            done,
                            style: TextStyle(color: color, fontSize: 16.0),
                          ),
                          Text(
                            'تعديل الوصف',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            textAlign: TextAlign.right,
                            maxLength: 70,
                            controller: _descriptionController,
                            decoration: InputDecoration(
                                hintText: 'وصف العمل  ', counterText: ''),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'أدخل وصف العمل';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: heightSize(context, 4),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              setState(() {
                                chargement = true;
                              });
                              await updateTask(_user.groupeId, _task.id,
                                  _descriptionController.text);
                              setState(() {
                                done = 'تم تعديل العمل بنجاح';
                                chargement = false;
                              });
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 600),
                                      child: Admin()));
                            },
                            minWidth: width - 60,
                            height: heightSize(context, 7),
                            color: LightColors.kBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Text(
                              'تعديل الوصف',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: heightSize(context, 2),
                          ),
                          Divider(
                            height: 2.0,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: heightSize(context, 2),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              await popUpDeleteTask(
                                  context, _user.groupeId, _task.id);
                            },
                            minWidth: width - 60,
                            height: heightSize(context, 7),
                            color: LightColors.kRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Text(
                              'حذف العمل',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
