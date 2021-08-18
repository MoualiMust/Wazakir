import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class CreateTasks {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser;

  Future<bool> createNewTask(
      groupeId, groupeNom, taskNom, taskDescription) async {
    bool res = false;
    final id = Uuid().v1();
    String today = DateTime.now().toString();
    await _db
        .collection('groupes')
        .doc(groupeId)
        .set({'groupeNom': groupeNom, 'admin': _auth.uid }).then((value) async {
      await _db
          .collection('groupes')
          .doc(groupeId)
          .collection('tasks')
          .doc(id)
          .set({
        'id': id,
        'date': today,
        'nom': taskNom,
        'description': taskDescription,
        'nmbrUser': 1,
        'score': 0,
        'scoreHier': 0,
        'scoreTotale': 0
      }).then((value) async {
        await _db
            .collection('groupes')
            .doc(groupeId)
            .collection('tasks')
            .doc(id)
            .collection('users')
            .doc(_auth.uid)
            .set({'done': false});
      }).then((value) async {
        await _db
            .collection('users')
            .doc(_auth.uid)
            .update({'groupeId': groupeId}).then((value) {
          return true;
        }).then((value) => res = true);
      });
    });
    return res;
  }
}
