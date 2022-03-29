import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/resources/app_strings.dart';

class _DeleteConfirmDialog extends StatelessWidget {
  final Widget? content;
  final List<Widget> actions;
  final Widget? title;
  const _DeleteConfirmDialog(
      {Key? key, this.content, this.title, this.actions = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb){
      return AlertDialog(
        actions: actions,
        title: title,
        content: content,
        contentPadding: const EdgeInsets.all(20),
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
        actions: actions,
        title: title,
        content: content,
        contentPadding: const EdgeInsets.all(20),
      );
    }
  }
}

class AdaptiveDeleteConfirmDialog extends StatelessWidget {
  final String name;
  const AdaptiveDeleteConfirmDialog({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DeleteConfirmDialog(
      content: Text('${AppStrings.theTask} $name ${AppStrings.willBeDeleted}'),
      title: const Text(AppStrings.areYouSure),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text(AppStrings.yes),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text(AppStrings.no),
        )
      ],
    );
  }
}
