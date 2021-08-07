import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/auth/authService.dart';
import 'package:wazakir/auth/inscription.dart';
import 'package:wazakir/auth/oublie.dart';
import 'package:wazakir/screens/home_page.dart';
import 'package:wazakir/size_config.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/top_container.dart';

class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool chargement = false;
  String erreur = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return chargement
        ? Chargement()
        : WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
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
                        height: heightSize(context, 6),
                      ),
                      Text(
                        'تسجيل الدخول',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: heightSize(context, 4),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: heightSize(context, 5),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: <Widget>[
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
                    ],
                  ),
                ),
                SizedBox(height: heightSize(context, 1),),
                Text(
                  erreur,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: heightSize(context, 2),),
                MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => chargement = true);
                      String status = await AuthProvider().loginWithEmailPassword(
                          _emailController.text, _passwordController.text);
                      if (status == 'succes') {
                        Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 600),
                            child: HomePage()));
                        setState(() => chargement = false);
                      } else if (status == 'user-not-found') {
                        setState(() => chargement = false);
                        setState(() => erreur = 'لا يوجد مشترك بهذا البريد');
                      } else if (status == 'invalid-email') {
                        setState(() => chargement = false);
                        setState(() => erreur = 'البريد الإلكتروني غير صالح');
                      } else if (status == 'wrong-password') {
                        setState(() => chargement = false);
                        setState(() => erreur = 'الرمز السري غير صحيح');
                      } else {
                        setState(() => chargement = false);
                        setState(() =>
                            erreur = 'لديكم مشكل، حاول مرة أخرى');
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
                    'تسجيل الدخول',
                    style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
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
                            duration: Duration(milliseconds: 500),
                            child: Oublie()));
                  },
                  child: Text(
                    'هل نسيت كلمة السر ؟',
                    style: TextStyle(
                      color: LightColors.kBlue,
                      fontSize: 18.0, fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  height: heightSize(context, 8),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 600),
                            child: Inscription()));
                  },
                  minWidth: width - 60,
                  height: heightSize(context, 7),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Text(
                    'إنشاء حساب',
                    style: TextStyle(color: LightColors.kBlue, fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
      ),
    ),
        );
  }
}
