import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showAdaptiveDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required Widget Function(BuildContext) builder,
}) {
  if (Platform.isIOS) {
    return showCupertinoDialog<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: builder,
    );
  } else {
    return showDialog<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: builder,
    );
  }
}
