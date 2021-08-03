
import 'package:flutter/foundation.dart';
import 'package:wazakir/models/tasks.dart';

class TaskProvider with ChangeNotifier {
  List<Tasks> _tasks = [];

  List<Tasks> _tasksDone = [];
  List<Tasks> _tasksNotDone = [];

  /*Future<List<Tasks>> getAllTasks() async {
    await FireStoreService().getTasks().then((value) => _tasks = value);
    return _tasks;
  }*/

  void addTaskDone(Tasks element) {
    _tasksDone.add(element);
    notifyListeners();
  }

  List<Tasks> get tasksDone {
    return _tasksDone;
  }

  void addTaskNotDone(Tasks element) {
    _tasksNotDone.add(element);
    notifyListeners();
  }

  List<Tasks> get tasksNotDone {
    return _tasksNotDone;
  }

  void cleanTasks() {
    _tasksDone.clear();
    _tasksNotDone.clear();
  }
}
