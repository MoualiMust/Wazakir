import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/top_container.dart';

class ProfilContainer extends StatefulWidget {
  final nom;
  final score;
  ProfilContainer(this.nom, this.score);

  @override
  _ProfilContainerState createState() => _ProfilContainerState();
}

class _ProfilContainerState extends State<ProfilContainer> {
  dynamic score = 100;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (widget.score > 100)
      score = 100;
    else
      score = widget.score;
    return TopContainer(
      height: 140,
      width: width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 5.0,
                    animation: true,
                    percent: score * 0.01,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: LightColors.kRed,
                    backgroundColor: LightColors.kDarkYellow,
                    center: CircleAvatar(
                      backgroundColor: LightColors.kBlue,
                      radius: 32.0,
                      backgroundImage: AssetImage(
                        'assets/images/avatar.png',
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          widget.nom,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: LightColors.kDarkBlue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '$score % نسبة الأداء',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ]),
    );
  }
}
