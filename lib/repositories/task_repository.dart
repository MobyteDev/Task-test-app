import 'dart:collection';

import 'package:todo_list/data/task_model.dart';
import 'package:todo_list/repositories/main_repository.dart';

class TaskRepository implements MainRepository {
  static final List<TaskModel> _tasks = [];
  @override
  void addTask(TaskModel task) {
    _tasks.add(task);
  }

  @override
  void toggleCompletion(String taskId) {
    var task = _tasks.firstWhere((element) => element.id == taskId);
    task.isCompleted = !task.isCompleted;
  }

  @override
  void deleteTask(String taskId) {
    _tasks.removeWhere((element) => element.id == taskId);
  }

  @override
  void editTask(String taskId, String newName) {
    var task = _tasks.firstWhere((element) => element.id == taskId);
    var index = _tasks.indexOf(task);
    _tasks.removeAt(index);
    _tasks.insert(index, task.copyWith(name: newName));
  }

  static UnmodifiableListView<TaskModel> get tasks =>
      UnmodifiableListView(_tasks);
}
