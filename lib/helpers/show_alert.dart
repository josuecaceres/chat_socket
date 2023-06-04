import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              elevation: 5,
              textColor: Colors.blue,
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
