import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/auth/authService.dart';
import 'package:wazakir/auth/connexion.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/chargement.dart';

import '../../size_config.dart';

popUpLogOut(BuildContext context) async {
  bool chargement = false;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return chargement
            ? Chargement()
            : Container(
                child: AlertDialog(
                  scrollable: true,
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'تسجيل الخروج ؟',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: heightSize(context, 2.5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: LightColors.kBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'لا',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              height: heightSize(context, 7),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                await AuthProvider().signOut(context);
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        duration: Duration(milliseconds: 500),
                                        child: Connexion()));
                              },
                              color: LightColors.kBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'نعم',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              height: heightSize(context, 7),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
      });
}
