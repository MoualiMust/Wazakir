import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/auth/authService.dart';
import 'package:wazakir/auth/connexion.dart';
import 'package:wazakir/screens/home_page.dart';
import 'package:wazakir/size_config.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/top_container.dart';

class Inscription extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  bool chargement = false;
  String erreur = '';

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
                            height: 50,
                          ),
                          Text(
                            'إنشاء حساب جديد',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightSize(context, 5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _nomController,
                            textAlign: TextAlign.right,
                            decoration:
                                const InputDecoration(hintText: 'إسم مستعار'),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'إسم مستعار';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: heightSize(context, 1.5),
                          ),
                          TextFormField(
                            textAlign: TextAlign.right,
                            controller: _emailController,
                            decoration: const InputDecoration(
                                hintText: 'البريد الإلكتروني  '),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'أدخل البريد الإلكتروني';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: heightSize(context, 1.5),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                                hintText: 'الرمز السري  '),
                            validator: (val) => val.length < 6
                                ? 'يحتوي على أقل من ٦ رموز'
                                : null,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: heightSize(context, 1.5),
                          ),
                          TextFormField(
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                                hintText: 'تأكيد الرمز السري  '),
                            validator: (val) => val != _passwordController.text
                                ? 'تأكيد الرمز السري'
                                : null,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightSize(context, 1),
                    ),
                    Text(
                      erreur,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: heightSize(context, 2),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => chargement = true);
                          String status = await AuthProvider()
                              .signUpWithEmailPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                  _nomController.text);
                          if (status == 'succes') {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 600),
                                    child: HomePage()));
                            setState(() => chargement = false);
                          } else if (status == 'email-already-in-use') {
                            setState(() => chargement = false);
                            setState(() => erreur = 'بريد إلكتروني مستعمل');
                          } else if (status == 'invalid-email') {
                            setState(() => chargement = false);
                            setState(
                                () => erreur = 'البريد الإلكتروني غير صالح');
                          } else if (status == 'wrong-password') {
                            setState(() => chargement = false);
                            setState(() => erreur = 'الرمز السري غير صحيح');
                          } else {
                            setState(() => chargement = false);
                            setState(
                                () => erreur = 'لديكم مشكل، حاول مرة أخرى');
                          }
                        }
                      },
                      minWidth: width - 60,
                      height: heightSize(context, 7),
                      color: LightColors.kBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text(
                        'تسجيل',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: heightSize(context, 4),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 500),
                                child: Connexion()));
                      },
                      minWidth: width - 60,
                      height: heightSize(context, 7),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text(
                        'دخول',
                        style: TextStyle(
                            color: LightColors.kBlue,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
