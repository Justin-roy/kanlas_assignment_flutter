// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

class AlertDialogPopUp extends StatelessWidget {
  const AlertDialogPopUp({
    required this.title,
    this.titlePadding,
    this.actions,
    this.content,
    Key? key,
  }) : super(key: key);
  final EdgeInsetsGeometry? titlePadding;
  final Widget title;
  final List<Widget>? actions;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
      child: AlertDialog(
        titlePadding: titlePadding,
        backgroundColor: Colors.grey.shade200.withOpacity(0.5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        title: title,
        content: content,
        actions: actions ??
            [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
      ),
    );
  }
}
