import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:wazakir/models/tasks.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/services/getAllUsers.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

Future<Tasks> getTask(String groupeId, String taskId) async {
  Tasks task;
  await _db
      .collection('groupes')
      .doc(groupeId)
      .collection('tasks')
      .doc(taskId)
      .get()
      .then((value) {
    task = Tasks.fromFirestore(value.data());
  });
  return task;
}

Future<bool> addTaskToGroupe(
    String groupeId, String nom, String description) async {
  bool res = false;
  List<Users> users = [];
  await getAllUsers(groupeId).then((value) => users = value);
  final id = Uuid().v1();
  final today = DateTime.now();
  String day = (today.year).toString() +
      '-' +
      (today.month).toString() +
      '-' +
      (today.day).toString();
  await _db
      .collection('groupes')
      .doc(groupeId)
      .collection('tasks')
      .doc(id)
      .set({
    'id': id,
    'date': day,
    'nom': nom,
    'description': description,
    'nmbrUser': users.length,
    'score': 0,
    'scoreHier': 0,
    'scoreTotale': 0
  }).then((value) async {
    await Future.forEach(users, (element) async {
      await _db
          .collection('groupes')
          .doc(groupeId)
          .collection('tasks')
          .doc(id)
          .collection('users')
          .doc(element.id)
          .set({'done': false});
    }).then((value) => res = true);
  });
  return res;
}

Future<void> deletetask(String groupeId, String taskId) async {
  await _db
      .collection('groupes')
      .doc(groupeId)
      .collection('tasks')
      .doc(taskId)
      .delete();
}

Future<void> updateTask(
    String groupeId, String taskId, String description) async {
  await _db
      .collection('groupes')
      .doc(groupeId)
      .collection('tasks')
      .doc(taskId)
      .update({'description': description});
}
