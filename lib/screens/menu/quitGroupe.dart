import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/screens/first_screen.dart';
import 'package:wazakir/services/addUserTasks.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/chargement.dart';

import '../../size_config.dart';

popUpQuiterGroupe(BuildContext context, String groupeId) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
                child: AlertDialog(
                  scrollable: true,
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'هل حقا تريدون الخروج من هذه المجموعة نهائيا ؟',
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
                                await deleteUserFromGroupe(groupeId);
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        duration: Duration(milliseconds: 500),
                                        child: FirstScreen()));
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
