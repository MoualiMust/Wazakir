import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wazakir/models/tasks.dart';
import 'package:wazakir/models/user.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

Future<List<Users>> getAllUsers(String groupeId) async {
  List<Users> users = [];
  List<Users> newUsers = [];
  var res = await _db.collection('users').get();
  users = res.docs.map((e) => Users.fromFirestore(e.data())).toList();
  await Future.forEach(users, (element) {
    if (element.groupeId == groupeId) newUsers.add(element);
  });
  return newUsers;
}
