import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/data/task_model.dart';
import 'package:todo_list/repositories/main_repository.dart';
import 'package:todo_list/services/id_generator.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final MainRepository _repository;
  TaskBloc(this._repository) : super(TaskInitial()) {
    on<AddTaskEvent>(_onAdd);
    on<EditTaskEvent>(_onEdit);
    on<RemoveTaskEvent>(_onRemove);
    on<ToggleCompletionEvent>(_onToggle);
  }

  void _onAdd(AddTaskEvent event, Emitter emit) {
    _repository.addTask(TaskModel(
      id: IdGenerator.getRandomString(8),
      name: event.name,
    ));
    emit(TaskInitial());
  }

  void _onEdit(EditTaskEvent event, Emitter emit) {
    _repository.editTask(event.taskId, event.newName);
    emit(TaskInitial());
  }

  void _onRemove(RemoveTaskEvent event, Emitter emit) {
    _repository.deleteTask(event.taskId);
    emit(TaskInitial());
  }

  void _onToggle(ToggleCompletionEvent event, Emitter emit) {
    _repository.toggleCompletion(event.taskId);
    emit(TaskInitial());
  }
}
