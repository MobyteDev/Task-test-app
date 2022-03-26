import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/bloc/task_bloc.dart';
import 'package:todo_list/data/task_model.dart';
import 'package:todo_list/widgets/delete_confirm_dialog.dart';
import 'package:todo_list/widgets/show_adaptive_dialog.dart';
import 'package:todo_list/widgets/text_field_dialog.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;
  const TaskItem({Key? key, required this.taskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checked = taskModel.isCompleted;
    return CheckboxListTile(
      key: ValueKey(taskModel.id),
      activeColor: Colors.green,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(taskModel.name),
      value: checked,
      secondary: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () async {
                showAdaptiveDialog(
                  context: context,
                  builder: (_) {
                    return AdaptiveTextFieldDialog(
                      task: taskModel,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () async {
                bool? delete = await showAdaptiveDialog<bool>(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AdaptiveDeleteConfirmDialog(name: taskModel.name);
                  },
                );
                if (delete!) {
                  BlocProvider.of<TaskBloc>(context)
                      .add(RemoveTaskEvent(taskModel.id));
                }
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      onChanged: (newval) {
        BlocProvider.of<TaskBloc>(context)
            .add(ToggleCompletionEvent(taskModel.id));
      },
    );
  }
}
