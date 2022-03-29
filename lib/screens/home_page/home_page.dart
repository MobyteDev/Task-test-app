import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/bloc/task_bloc.dart';
import 'package:todo_list/repositories/task_repository.dart';
import 'package:todo_list/resources/app_strings.dart';
import 'package:todo_list/screens/home_page/widgets/task_item.dart';
import 'package:todo_list/widgets/show_adaptive_dialog.dart';
import 'package:todo_list/widgets/text_field_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.todoList),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    final isEmpty = TaskRepository.tasks.isEmpty;
                    if (isEmpty) {
                      return const Center(child: Text(AppStrings.noTask));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: ListView.builder(
                        itemCount: TaskRepository.tasks.length,
                        itemBuilder: (ctx, index) {
                          return TaskItem(
                            taskModel: TaskRepository.tasks[index],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showAdaptiveDialog(
                    context: context,
                    builder: (_) {
                      return const AdaptiveTextFieldDialog();
                    },
                  );
                },
                child: const Text(AppStrings.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
