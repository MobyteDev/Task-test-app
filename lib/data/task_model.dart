class TaskModel {
  final String id;
  final String name;
  bool isCompleted;

  TaskModel({required this.id, required this.name, this.isCompleted = false});

  TaskModel copyWith({String? name}) {
    return TaskModel(
      id: id,
      name: name ?? this.name,
      isCompleted: isCompleted,
    );
  }
  @override
  String toString() {
    return '{id = $id, name = $name, isCompleted = $isCompleted}';
  }
}
