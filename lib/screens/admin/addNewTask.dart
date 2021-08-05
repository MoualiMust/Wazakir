import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/screens/admin/admin.dart';
import 'package:wazakir/services/setting.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/top_container.dart';

import '../../size_config.dart';

class AddNewTask extends StatefulWidget {
  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String done = '';
  bool chargement = true;
  Users _user;
  bool res = false;

  getData() async {
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

  var color = Colors.green[800];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return chargement
        ? Chargement()
        : Scaffold(
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
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'إضافة عمل جديد',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Text(
                            done,
                            style: TextStyle(color: color, fontSize: 16.0),
                          ),
                          Text(
                            'إضافة عمل',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w700),
                          ),
                          Text('( . . . أذكارالصباح، المساء، صدقة، ورد يومي)'),
                          TextFormField(
                            textAlign: TextAlign.right,
                            maxLength: 25,
                            controller: _nomController,
                            decoration: InputDecoration(
                                hintText: 'إسم العمل  ', counterText: ''),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'أدخل إسم العمل';
                              }
                              return null;
                            },
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
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  chargement = true;
                                });
                                await addTaskToGroupe(
                                        _user.groupeId,
                                        _nomController.text,
                                        _descriptionController.text)
                                    .then((value) => res = value);
                                if (res == true)
                                  setState(() {
                                    done = 'تمت إضافة العمل بنجاح';
                                    _nomController.clear();
                                    _descriptionController.clear();
                                    chargement = false;
                                  });
                                else
                                  setState(() {
                                    done = 'لم يتم إضافة العمل، حاول ';
                                    color = Colors.red;
                                    chargement = false;
                                  });
                              }
                            },
                            minWidth: width - 60,
                            height: heightSize(context, 7),
                            color: LightColors.kBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Text(
                              'إضافة العمل',
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 600),
                                      child: Admin()));
                            },
                            minWidth: width - 60,
                            height: heightSize(context, 7),
                            color: LightColors.kRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Text(
                              'إنهاء',
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
