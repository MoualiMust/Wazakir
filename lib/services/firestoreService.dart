import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wazakir/models/tasks.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/providers/tasksProvider.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser;
  Users _user;

  Future<void> saveUser(String nom) async {
    await _db.collection('users').doc(_auth.uid).set({
      'id': _auth.uid,
      'nom': nom,
      'score': 0,
      'date': "2222-25-87",
      'scoreHier': 0,
      'scoreTotale': 0,
      'groupeId':""
    });
  }

  Future<Users> getUser() async {
    await _db.collection('users').doc(_auth.uid).get().then((value) {
      _user = Users.fromFirestore(value.data());
    });
    return _user;
  }

  Future<List<Tasks>> getTasks(String groupeId) async {
    List<Tasks> tasks = [];
    var res = await _db
        .collection('groupes')
        .doc(groupeId)
        .collection('tasks')
        .get();
    tasks = res.docs.map((e) => Tasks.fromFirestore(e.data())).toList();
    return tasks;
  }

  Future<void> taskDone(
    BuildContext context,
  ) async {
    await getUser();
    Provider.of<TaskProvider>(context, listen: false).cleanTasks();

    List<Tasks> tasks = [];
    await getTasks(_user.groupeId).then((value) => tasks = value);
    await Future.forEach(tasks, (element) async {
      
      var user = await _db
          .collection('groupes')
          .doc(_user.groupeId)
          .collection('tasks')
          .doc(element.id)
          .collection('users')
          .doc(_auth.uid)
          .get();
      if (user.data()['done'] == true)
        Provider.of<TaskProvider>(context, listen: false).addTaskDone(element);
      else
        Provider.of<TaskProvider>(context, listen: false)
            .addTaskNotDone(element);
    });
  }

  Future<void> toDane(String idTask, String idUser, dynamic scoreUser,
      int nmbrUser, dynamic scoreTask, int lenghtTask) async {
    await getUser();
    await _db
        .collection('groupes')
        .doc(_user.groupeId)
        .collection('tasks')
        .doc(idTask)
        .collection('users')
        .doc(idUser)
        .update({'done': true}).then((value) {
      return true;
    });
    await _db
        .collection('users')
        .doc(idUser)
        .update({'score': scoreUser + (100 / lenghtTask)});
    await _db
        .collection('groupes')
        .doc(_user.groupeId)
        .collection('tasks')
        .doc(idTask)
        .update({'score': scoreTask + (100 / nmbrUser)});
  }

  Future<void> deleteScoreTask() async {
    await getUser();
    List<Tasks> tasks = [];
    await getTasks(_user.groupeId).then((value) => tasks = value);
    var today = DateTime.now();
    String day = (today.year).toString() +
        '-' +
        (today.month).toString() +
        '-' +
        (today.day).toString();
    String newDay = (today.year).toString() +
        '-' +
        (today.month).toString() +
        '-' +
        (today.day + 1).toString();
    await Future.forEach(tasks, (element) async {
      if (day.compareTo(element.date) > 0) {
        await _db
            .collection('groupes')
            .doc(_user.groupeId)
            .collection('tasks')
            .doc(element.id)
            .update({
          'score': 0,
          'scoreHier': element.score,
          'date': newDay,
          'scoreTotale': (element.score + element.scoreTotale) / 2
        });
        await _db
            .collection('groupes')
            .doc(_user.groupeId)
            .collection('tasks')
            .doc(element.id)
            .collection('users')
            .doc(_auth.uid)
            .update({'done': false}).then((value) {
          return true;
        });
      }
    });
  }

  Future<void> deleteScoreUser(
      String idUser, dynamic score, dynamic scoreTotale, String date) async {
    var today = DateTime.now();
    String day = (today.year).toString() +
        '-' +
        (today.month).toString() +
        '-' +
        (today.day).toString();
    String newDay = (today.year).toString() +
        '-' +
        (today.month).toString() +
        '-' +
        (today.day + 1).toString();
    if (day.compareTo(date) > 0) {
      await _db.collection('users').doc(idUser).update({
        'score': 0,
        'scoreHier': score,
        'date': newDay,
        'scoreTotale': (score + scoreTotale) / 2
      });
    }
  }
}
