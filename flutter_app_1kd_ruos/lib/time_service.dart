import 'package:flutter/material.dart';

class TimeService {
  static int getDifferenceOfTime(TimeOfDay timeA, TimeOfDay timeB) {
    final int differenceInHours = (timeA.hour - timeB.hour).abs();
    int differenceInMinutes = (timeA.minute - timeB.minute).abs();

    return (differenceInHours * 60) + differenceInMinutes;
  }

  static TimeOfDay getCurrentTime() => TimeOfDay.now();

  static Future<TimeOfDay?> timeSelector(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: getCurrentTime(),
    );
  }

}