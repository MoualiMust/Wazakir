import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wazakir/services/createTasks.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/popUpAddGroupe.dart';
import 'package:wazakir/widgets/top_container.dart';

import '../size_config.dart';

class CreateNewTaskPage extends StatefulWidget {
  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _groupeController = TextEditingController();

  String done = '';
  bool chargement = false;

  var color = Colors.green[800];

  final groupId = Uuid().v1();
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
                                  'إنشاء مجموعة جديدة',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            maxLength: 25,
                            textAlign: TextAlign.right,
                            controller: _groupeController,
                            decoration: InputDecoration(
                                hintText: 'إسم المجموعة  ', counterText: ''),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'أدخل إسم العمل';
                              }
                              return null;
                            },
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
                                await CreateTasks()
                                    .createNewTask(
                                        groupId,
                                        _groupeController.text,
                                        _nomController.text,
                                        _descriptionController.text)
                                    .then((value) {
                                  if (value == true)
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
                              popUpAddGroupe(context, _groupeController.text);
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
