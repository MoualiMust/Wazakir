import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/screens/admin/admin.dart';
import 'package:wazakir/services/setting.dart';
import 'package:wazakir/theme/colors/light_colors.dart';

import '../../size_config.dart';

popUpDeleteTask(
  BuildContext context,
  String groupeId,
  String taskId,
) async {
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
                    'تأكيد الحذف',
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
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        height: heightSize(context, 7),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await deletetask(groupeId, taskId);
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 500),
                                  child: Admin()));
                        },
                        color: LightColors.kBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'نعم',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
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
