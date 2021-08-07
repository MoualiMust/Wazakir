import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/auth/authService.dart';
import 'package:wazakir/auth/connexion.dart';
import 'package:wazakir/auth/inscription.dart';
import 'package:wazakir/size_config.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/top_container.dart';

class Oublie extends StatefulWidget {
  @override
  _OublieState createState() => _OublieState();
}

class _OublieState extends State<Oublie> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
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
                            height: heightSize(context, 6),
                          ),
                          Text(
                            'تغيير كلمة السر',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: heightSize(context, 4),
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
                              .resetPassword(_emailController.text);
                          if (status == 'succes') {
                            setState(() => chargement = false);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: AlertDialog(
                                      scrollable: true,
                                      content: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              'ستتلقون رسالة نصية على بريدكم الإلكتروني من أجل تغيير رمزكم السري',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    heightSize(context, 1.5)),
                                            Text(
                                              '${_emailController.text}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: LightColors.kBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                            SizedBox(
                                                height:
                                                    heightSize(context, 2.5)),
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .bottomToTop,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        child: Connexion()));
                                              },
                                              color: LightColors.kBlue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                'حسنا',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0),
                                              ),
                                              height: heightSize(context, 7),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } else if (status == 'user-not-found') {
                            setState(() => chargement = false);
                            setState(
                                () => erreur = 'لا يوجد مشترك بهذا البريد');
                          } else if (status == 'invalid-email') {
                            setState(() => chargement = false);
                            setState(
                                () => erreur = 'البريد الإلكتروني غير صالح');
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
                        'تأكيد',
                        style: TextStyle(
                            color: Colors.white,
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
