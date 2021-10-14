import 'package:flutter/material.dart';

class TimeService {
  static int getDifferenceOfTime(TimeOfDay timeA, TimeOfDay timeB) {
    final int differenceInHours = (timeA.hour - timeB.hour).abs();
    int differenceInMinutes = (timeA.minute - timeB.minute).abs();

    return (differenceInHours * 60) + differenceInMinutes;
  }

  static TimeOfDay getCurrentTime() => TimeOfDay.now();

  static Future<DateTime?> timeSelector(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
  }
}
