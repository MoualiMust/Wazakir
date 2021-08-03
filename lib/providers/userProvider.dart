import 'package:flutter/foundation.dart';
import 'package:wazakir/models/user.dart';
import 'package:wazakir/services/firestoreService.dart';

class UserProvider with ChangeNotifier {
  Users _user;

  List<Users> users = [];

  Future<Users> getUser() async {
    await FireStoreService().getUser().then((value) => _user = value);
    return _user;
  }

  Future<bool> addUsers(Users user) async {
    users.add(user);
    notifyListeners();
    return true;
  }
}
