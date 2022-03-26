// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/data/task_model.dart';


import 'bloc_test.dart';

void main() {
  group('Bloc functionality test', () {
    final repo = MockRepository();
    test('Add task test', () {
      repo.addTask(TaskModel(id: '78', name: '7'));
      repo.addTask(TaskModel(id: '11', name: 'Task'));
      repo.addTask(TaskModel(id: '31', name: 'name'));
      expect(MockRepository.tasks.length, 3);
    });
    test('Edit task test', () {
      repo.editTask('78', 'NewTask');
      expect(MockRepository.tasks.length, 3);
      expect(
          MockRepository.tasks.firstWhere((element) => element.id == '78').name,
          'NewTask');
      expect(() => repo.editTask('qqq', 'sa'), throwsA(isA<StateError>()));
    });
    test('Remove task test', () {
      repo.deleteTask('11');
      expect(MockRepository.tasks.length, 2);
      expect(() => repo.editTask('11', 'sa'), throwsA(isA<StateError>()));
      repo.deleteTask('11');
      expect(MockRepository.tasks.length, 2);
    });
    test('Toggle completion test', () {
      repo.addTask(TaskModel(id: '7566', name: 'LUL'));
      expect(MockRepository.tasks.length, 3);
      repo.toggleCompletion('31');
      expect(MockRepository.tasks.firstWhere((element) => element.id == '31').isCompleted, true);
      repo.deleteTask('78');
      expect(MockRepository.tasks.length, 2);
      expect(MockRepository.tasks.firstWhere((element) => element.id == '31').isCompleted, true);
      expect(MockRepository.tasks.firstWhere((element) => element.id == '7566').isCompleted, false);
      expect(() => repo.toggleCompletion('78'), throwsA(isA<StateError>()));
    });
  });
}
