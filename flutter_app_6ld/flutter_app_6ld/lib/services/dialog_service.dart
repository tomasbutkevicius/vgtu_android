import 'package:flutter/material.dart';

class DialogService {
  static void displayDialog(String titleText, String contentText, BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}