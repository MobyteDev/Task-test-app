import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/bloc/task_bloc.dart';
import 'package:todo_list/data/task_model.dart';
import 'package:todo_list/resources/app_strings.dart';

class _TextFieldDialog extends StatelessWidget {
  final Widget? content;
  final List<Widget> actions;
  final Widget? title;
  const _TextFieldDialog(
      {Key? key, this.content, this.title, this.actions = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return AlertDialog(
        content: content,
        contentPadding: const EdgeInsets.all(20),
        title: title,
        actions: actions,
      );
    }
    else if (Platform.isIOS) {
      return CupertinoAlertDialog(
        content: content,
        title: title,
        actions: actions,
      );
    } else {
      return AlertDialog(
        content: content,
        contentPadding: const EdgeInsets.all(20),
        title: title,
        actions: actions,
      );
    }
  }
}

class AdaptiveTextFieldDialog extends StatefulWidget {
  final TaskModel? task;
  const AdaptiveTextFieldDialog({Key? key, this.task}) : super(key: key);

  @override
  State<AdaptiveTextFieldDialog> createState() =>
      _AdaptiveTextFieldDialogState();
}

class _AdaptiveTextFieldDialogState extends State<AdaptiveTextFieldDialog> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.requestFocus();
    controller = TextEditingController(text: widget.task?.name);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  String? errorText;
  @override
  Widget build(BuildContext context) {
    final edit = widget.task != null;
    return _TextFieldDialog(
      title: Text(edit ? AppStrings.edit : AppStrings.add),
      content: kIsWeb 
      ? TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              focusNode: focusNode,
              controller: controller,
              decoration: InputDecoration(errorText: errorText),
            )
      : Platform.isIOS
          ? CupertinoTextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              focusNode: focusNode,
              controller: controller,
            )
          : TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              focusNode: focusNode,
              controller: controller,
              decoration: InputDecoration(errorText: errorText),
            ),
      actions: [
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              if (edit) {
                BlocProvider.of<TaskBloc>(context).add(EditTaskEvent(
                  taskId: widget.task!.id,
                  newName: controller.text.trim(),
                ));
                Navigator.of(context).pop();
              } else {
                BlocProvider.of<TaskBloc>(context)
                    .add(AddTaskEvent(controller.text.trim()));
                Navigator.of(context).pop();
              }
            } else {
              setState(() {
                errorText = AppStrings.error;
              });
            }
          },
          child: const Text(AppStrings.done),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(AppStrings.cancel),
        ),
      ],
    );
  }
}
