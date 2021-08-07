import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazakir/auth/connexion.dart';
import 'package:wazakir/screens/first_screen.dart';
import 'package:wazakir/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/services/firestoreService.dart';

class Utilisateur {
  String idUtil;

  Utilisateur({this.idUtil});
}

class StreamProviderAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  //creation d'un obj utilisateur provenant de la classe firebaseUser
  Utilisateur _utilisateurDeFirebaseUser(User user) {
    return user != null ? Utilisateur(idUtil: user.uid) : null;
  }

  //la difussion de l'auth de l'utilisateur

  Stream<Utilisateur> get utilisateur {
    return _auth.authStateChanges().map(_utilisateurDeFirebaseUser);
  }
}

class Passerelle extends StatefulWidget {
  @override
  _PasserelleState createState() => _PasserelleState();
}

void fetchGroupe(BuildContext context) async {
  await FireStoreService().getUser().then((value) {
    if (value.groupeId == "")
      return Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 600),
              child: FirstScreen()));
    else
      return Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 600),
              child: HomePage()));
  });
}

class _PasserelleState extends State<Passerelle> {
  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    if (utilisateur == null) {
      return Connexion();
    } else
      fetchGroupe(context);
  }
}
