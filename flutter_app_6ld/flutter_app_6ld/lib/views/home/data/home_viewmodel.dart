import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_6ld/services/dialog_service.dart';
import 'package:flutter_app_6ld/services/time_service.dart';
import 'package:flutter_app_6ld/utils/state_management.dart';

class HomeViewModel extends StateManager {
  final String title = 'Lab_6';
  String outputFieldText = '';
  ValueNotifier<String> daysUntilSelectedDateText = ValueNotifier("");
  ValueNotifier<String> randomNumber = ValueNotifier("");

  int daysUntilSelectedDateNum = 0;
  final State _state;
  bool timerStarted = false;
  late Timer timer;

  HomeViewModel(this._state);

  Future<void> dateBtnClick(BuildContext context) async {
    DateTime? selectedTime = await TimeService.timeSelector(context);

    if (selectedTime != null) {
      // final differenceInMinutes = TimeService.getDifferenceOfTime(now, selectedTime);
      //
      // const String dialogTitleText = "Skirtumas minutėmis";
      // final String contentTitleText = "Skirtumas tarp dabar ir nurodyto laiko yra $differenceInMinutes min";
      //
      // dropdownTitles[0] = contentTitleText;
      _setupOutputField(selectedTime);
    }
  }

  void _setupOutputField(DateTime selectedTime) {
    outputFieldText = "";
    _addSelectedDateText(selectedTime);
    outputFieldText += "\n";
    _addTodayDateText();
    _showDateDiffFor5Seconds(selectedTime);
    rebuildWidget(_state);
  }

  void _addTodayDateText() {
    outputFieldText += "TODAY IS: ";

    DateTime today = DateTime.now();

    outputFieldText += today.year.toString();
    outputFieldText += "-${today.month.toString()}";
    outputFieldText += "-${today.day.toString()}";
  }

  void _addSelectedDateText(DateTime selectedTime) {
    outputFieldText += "SELECTED DATE: ";

    outputFieldText += selectedTime.year.toString();
    outputFieldText += "-${selectedTime.month.toString()}";
    outputFieldText += "-${selectedTime.day.toString()}";
  }

  void stopRandomNumGen() {
    if(timerStarted){
      timer.cancel();
      timerStarted = !timerStarted;
    }
  }

  Future handleExit() async {
    await SystemNavigator.pop();
  }

  void _showDateDiffFor5Seconds(DateTime selectedTime) {
    int daysBetweenNum = daysBetween(selectedTime, DateTime.now());
    String daysBetweenText = daysBetweenNum.toString();
    daysUntilSelectedDateText.value = "Day difference to selected date: $daysBetweenText";
    daysUntilSelectedDateNum = daysBetweenNum;
    Future.delayed(const Duration(seconds: 5), () {
      daysUntilSelectedDateText.value = "";

      runRandomNumEverySecond(true);
    });
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).abs().round();
  }

  void runRandomNumEverySecond(bool fromDatePicker) {
    if(fromDatePicker){
      stopRandomNumGen();
    }
    if(timerStarted){
      return;
    }
    timerStarted = true;
    Random random = Random();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if(daysUntilSelectedDateNum != 0){
          randomNumber.value = random.nextInt(daysUntilSelectedDateNum).toString();
        } else {
          randomNumber.value = random.nextInt(100).toString();
        }
      },
    );
  }
}

/*int index = 0;
      Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) {
          if (index == text.length) {
            daysUntilSelectedDate.value = "";
              timer.cancel();
          } else {
            print(text[index]);
            daysUntilSelectedDate.value = text[index];
            index++;
          }
        },
      );*/
