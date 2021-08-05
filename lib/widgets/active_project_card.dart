import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ActiveProjectsCard extends StatelessWidget {
  final Color cardColor;
  final double loadingPercent;
  final String title;
  final String subtitle;

  ActiveProjectsCard({
    this.cardColor,
    this.loadingPercent,
    this.title,
    this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircularPercentIndicator(
                animation: true,
                radius: 60.0,
                percent: loadingPercent,
                lineWidth: 5.0,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white10,
                progressColor: Colors.white,
                center: Text(
                  '${(loadingPercent * 100).round()}%',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white54,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
