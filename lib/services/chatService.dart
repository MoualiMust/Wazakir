import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wazakir/models/chat.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance.currentUser;

Future<void> sendMessage(String groupeId, String message, String nom) async {
  var today = DateTime.now().toString();
  await _db
      .collection('groupes')
      .doc(groupeId)
      .collection('chat')
      .doc(today)
      .set({'id': _auth.uid, 'nom': nom, 'message': message, 'date': today});
}

Future<List<Chat>> getAllMessage(String groupId) async {
  List<Chat> messages = [];
  var res =
      await _db.collection('groupes').doc(groupId).collection('chat').get();
  messages = res.docs.map((e) => Chat.fromFirestore(e.data())).toList();
  return messages;
}
