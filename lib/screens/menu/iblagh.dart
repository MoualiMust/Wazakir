import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/screens/menu.dart';
import 'package:wazakir/services/joinGroupe.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/chargement.dart';

import '../../size_config.dart';

popUpIblagh(BuildContext context, String userId) async {
  String comment = '';
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
                          'إبلاغ عن مشكل أو عطب أو اقتراحات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: heightSize(context, 1),),
                        Container(
                          height: 100,
                          child: TextField(
                            textAlign: TextAlign.right,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (val) => comment = val,
                          ),
                        ),
                        SizedBox(height: heightSize(context, 2),),
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
                                'إلغاء',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              height: heightSize(context, 7),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                if(comment != '') await iblagh(userId, comment);
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        duration: Duration(milliseconds: 500),
                                        child: Menu()));
                              },
                              color: LightColors.kBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'إرسال',
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
