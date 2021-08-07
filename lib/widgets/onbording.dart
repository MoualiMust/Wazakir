import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/auth/connexion.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/top_container.dart';

import '../size_config.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  Widget text(String text) {
    return Center(
        child: Text(
      text,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26.0),
    ));
  }

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "مرحبا",
      "description":
          "وذكر هو تطبيق شبه إجتماعي يمَكِّن مستعميليه من إضافة الأعمال اليومية التي يرغبون في  أدائها في مجموعات، حيث يساعد هذا التطبيق على تذكيرك بالأعمال التي ترغب في أدائها في يومك و ليلتك، أو الأعمال التي تود أدائها مع اصدقائك"
    },
    {
      "title": "إحصائيات",
      "description":
          "هذا التطبيق يمكِّنك من معرفة نسبة أدائك لأعمال اليوم، ونسبة أدائك ليوم الأمس،  ومعدل الأداء منذ بدايتك في إستعمال التطبيق  كما يمكنك من معرفت نسبة أداء المجموعة لكل عمل، لليوم، و الأمس، و المعدل العام"
    },
    {
      "title": "المجموعة",
      "description":
          "يمكنك الإلتحاق بمجموعة أصدقائك عن طريق رمز خاص بكل مجموعة، كما يمكنك أن تنشئ مجموعة جديدة و ترسل رمزها إلى من تريد إضافته إلى المجموعة، يمكنكم أيضا التواصل داخل المجموعة عن طريق دردشة خاصة بالتطبيق"
    },
    {
      "title": "إعدادات",
      "description":
          "يستطيع رئيس المجموعة، الذي قام بإنشاء المجموعة أول مرة أن يضيف أعمال، او يقوم بتعديلات على العمل، او حذف العمل هذا التطبيق لا يجمع أي معلومة شخصية على مستعمليه، و حتى الإسم يمكن إستعمال إسم مستعار، وبريد إلكتروني مستعار أيضا"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: PageView.builder(
              reverse: true,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TopContainer(
                          width: MediaQuery.of(context).size.width,
                          height: heightSize(context, 18),
                          child: text(splashData[index]['title']),
                        ),
                      
                      SizedBox(
                        height: heightSize(context, 5),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.indigo[400],
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                splashData[index]['description'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  splashData.length,
                                  (index) => buildDot(index: 3 - index),
                                ),
                              ),
                              SizedBox(
                                height: heightSize(context, 10),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          duration: Duration(milliseconds: 600),
                                          child: Connexion()));
                                },
                                height: heightSize(context, 7),
                                color: LightColors.kDarkYellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Text(
                                  'إبدء',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xFFFF7643) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
