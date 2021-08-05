import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/screens/chart.dart';
import 'package:wazakir/screens/chat.dart';
import 'package:wazakir/screens/home_page.dart';
import 'package:wazakir/screens/menu.dart';
import 'package:wazakir/theme/colors/light_colors.dart';

class BarMenu extends StatefulWidget {
  final home;
  final chart;
  final chat;
  final menu;
  BarMenu(this.home, this.chart, this.chat, this.menu);
  @override
  _BarMenuState createState() => _BarMenuState();
}

class _BarMenuState extends State<BarMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      color: LightColors.kDarkYellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        duration: Duration(milliseconds: 600),
                        child: Menu()));
              },
              child: Icon(
                Icons.menu,
                color: widget.menu,
                size: 32,
              )),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        duration: Duration(milliseconds: 600),
                        child: Discution()));
              },
              child: Icon(
                Icons.chat_outlined,
                color: widget.chat,
                size: 32,
              )),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        duration: Duration(milliseconds: 600),
                        child: Chart()));
              },
              child: Icon(
                Icons.bar_chart_outlined,
                color: widget.chart,
                size: 32,
              )),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        duration: Duration(milliseconds: 600),
                        child: HomePage()));
              },
              child: Icon(
                Icons.home_outlined,
                color: widget.home,
                size: 32,
              )),
        ],
      ),
    );
  }
}
