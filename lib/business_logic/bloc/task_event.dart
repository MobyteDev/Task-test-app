part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String name;

  AddTaskEvent(this.name);
}

class RemoveTaskEvent extends TaskEvent {
  final String taskId;

  RemoveTaskEvent(this.taskId);
}

class EditTaskEvent extends TaskEvent {
  final String taskId;
  final String newName;

  EditTaskEvent({required this.taskId, required this.newName});
}

class ToggleCompletionEvent extends TaskEvent {
  final String taskId;

  ToggleCompletionEvent(this.taskId);
}
