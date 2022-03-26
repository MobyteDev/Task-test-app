
import 'package:todo_list/data/task_model.dart';

abstract class MainRepository {
  void deleteTask(String taskId);
  void addTask(TaskModel task);
  void editTask(String taskId, String newName);
  void toggleCompletion(String taskId);
}