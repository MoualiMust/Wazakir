import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wazakir/models/tasks.dart';
import 'package:wazakir/services/firestoreService.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance.currentUser;

List<Tasks> _tasks;
Future<void> addUserTasks(String groupeId) async {
  await FireStoreService().getTasks(groupeId).then((value) => _tasks = value);
  await Future.forEach(_tasks, (element) async {
    await _db
        .collection('groupes')
        .doc(groupeId)
        .collection('tasks')
        .doc(element.id)
        .update({'nmbrUser': element.nmbrUser + 1});
    await _db
        .collection('groupes')
        .doc(groupeId)
        .collection('tasks')
        .doc(element.id)
        .collection('users')
        .doc(_auth.uid)
        .set({'done': false});
  }).then((value) async {
    await _db.collection('users').doc(_auth.uid).update({'groupeId': groupeId});
  });
}

Future<void> deleteUserFromGroupe(String groupeId) async {
  await FireStoreService().getTasks(groupeId).then((value) => _tasks = value);
  await Future.forEach(_tasks, (element) async {
    await _db
        .collection('groupes')
        .doc(groupeId)
        .collection('tasks')
        .doc(element.id)
        .update({'nmbrUser': element.nmbrUser - 1});
    await _db
        .collection('groupes')
        .doc(groupeId)
        .collection('tasks')
        .doc(element.id)
        .collection('users')
        .doc(_auth.uid)
        .delete();
  }).then((value) async {
    await _db.collection('users').doc(_auth.uid).update({'groupeId': ""});
  });
}
