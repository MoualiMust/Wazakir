import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/models/chat.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/services/chatService.dart';
import 'package:wazakir/size_config.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:wazakir/widgets/barMenu.dart';
import 'package:wazakir/widgets/chargement.dart';
import 'package:wazakir/widgets/topContainer.dart';

class Discution extends StatefulWidget {
  @override
  _DiscutionState createState() => _DiscutionState();
}

class _DiscutionState extends State<Discution> {
  Users _user;
  bool chargement = true;

  List<Chat> messages = [];
  void getData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getUser()
        .then((value) {
      _user = value;
    });
    await getAllMessage(_user.groupeId).then((value) => messages = value);
    setState(() {
      chargement = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  String message = '';

  @override
  Widget build(BuildContext context) {
    return chargement
        ? Chargement()
        : Scaffold(
            bottomNavigationBar: BarMenu(
                Colors.white, Colors.white, LightColors.kRed, Colors.white),
            backgroundColor: LightColors.kLightYellow,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  ProfilContainer(_user.nom, _user.score),
                  SizedBox(
                    height: heightSize(context, 2),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          children: <Widget>[
                            for (int i = 0; i < messages.length;i++)
                              Column(
                                children: [
                                  SizedBox(height: heightSize(context, 1.5),),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.indigo[400],
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15))),
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text(
                                            messages[i].nom,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w700),
                                          ),
                                          Text(messages[i].message,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: heightSize(context, 1),
                                          ),
                                          Text(messages[i].date,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.0
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: heightSize(context, 1.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.indigo[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    textAlign: TextAlign.right,
                                    onChanged: (val) => message = val,
                                  ),
                                ),
                                SizedBox(
                                  width: widthSize(context, 3),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      chargement = true;
                                    });
                                    if (message != '')
                                      await sendMessage(
                                          _user.groupeId, message, _user.nom);
                                    await getAllMessage(_user.groupeId)
                                        .then((value) => messages = value);
                                    setState(() {
                                      chargement = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.send,
                                    size: 30,
                                    color: Colors.indigo,
                                  ),
                                ),
                                SizedBox(
                                  width: widthSize(context, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
