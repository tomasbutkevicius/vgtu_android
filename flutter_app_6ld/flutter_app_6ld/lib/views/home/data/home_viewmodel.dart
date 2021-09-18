import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_6ld/services/dialog_service.dart';
import 'package:flutter_app_6ld/services/time_service.dart';
import 'package:flutter_app_6ld/utils/state_management.dart';

class HomeViewModel extends StateManager {
  final String title = 'Lab_6';
  final String countSymbolsActionText = "Simoblių skaičius šiame tekste";
  final String spellSymbolsActionText = "Simoblių vardijimas po vieną";
  final List<String> dropdownTitles = ["Hello world!", "Sveikas pasauli!"];
  ValueNotifier<String> symbolSpeller = ValueNotifier("");

  final State _state;

  HomeViewModel(this._state);

  onSettingsClick(BuildContext context, int item) async {
    switch (item) {
      case 0:
        await _handleTimeDiffSelection(context);
        break;
      case 1:
        _handleExit();
    }
  }

  Future<void> _handleTimeDiffSelection(BuildContext context) async {
    final now = TimeService.getCurrentTime();
    TimeOfDay? selectedTime = await TimeService.timeSelector(context);

    if (selectedTime != null) {
      final differenceInMinutes = TimeService.getDifferenceOfTime(now, selectedTime);

      const String dialogTitleText = "Skirtumas minutėmis";
      final String contentTitleText = "Skirtumas tarp dabar ir nurodyto laiko yra $differenceInMinutes min";

      dropdownTitles[0] = contentTitleText;
      DialogService.displayDialog(dialogTitleText, contentTitleText, context);
      rebuildWidget(_state);
    }
  }

  Future _handleExit() async {
    await SystemNavigator.pop();
  }


  void onDropdownSelection(BuildContext context, String dropdownTitle, String selectionText) {
    if(selectionText == countSymbolsActionText){
      _handleCountSymbolAction(context, dropdownTitle);
      return;
    }
    if(selectionText == spellSymbolsActionText){
      _handleSpellSymbols(dropdownTitle);
    }
  }

  void _handleCountSymbolAction(BuildContext context, String text) {
    int symbolCount = text.length;
    final String dialogText = "Tekste yra $symbolCount simbolių";
    DialogService.displayDialog("Simbolių skaičius", dialogText, context);
    dropdownTitles[1] = dialogText;
    rebuildWidget(_state);
  }

  void _handleSpellSymbols(String text) {
    int index = 0;
      Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) {
          if (index == text.length) {
            symbolSpeller.value = "";
              timer.cancel();
          } else {
            print(text[index]);
            symbolSpeller.value = text[index];
            index++;
          }
        },
      );
  }
}
