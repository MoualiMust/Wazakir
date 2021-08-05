import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wazakir/services/addUserTasks.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

Future<bool> joinGroupe(String groupeId) async {
  bool res = false;
  await _db.collection('groupes').doc(groupeId).get().then((value) async {
    if (value.exists) {
      await addUserTasks(groupeId).then((value) => res = true);
      res = true;
    } else
      res = false;
  });
  return res;
}

Future<void> iblagh(String id, String iblagh) async {
  await _db.collection('iblagh').doc(id).set({'id': id, 'iblagh': iblagh});
}
