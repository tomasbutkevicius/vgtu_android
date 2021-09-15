import 'package:flutter/cupertino.dart';
import 'package:flutter_5ld/fragment_list_view.dart';

class FragmentView extends StatelessWidget {
  final String text;

  const FragmentView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return const FragmentListView(
        fragmentTitle: "",
        fragmentResult: "",
      );
    }

    if (_containsLettersAa()) {
      final int countOfA = _getCountOfLetterAa(text);
      return FragmentListView(
        fragmentTitle: "Raidės A(a) paieškos framgentas",
        fragmentResult: "Šiame tekste yra ${countOfA.toString()} simboliai A(a)",
      );
    }

    final vowelCount = _getVowelCount();
    final int capitalLetterCount = _getCapitalLetterCount(text);

    int lowerCaseLetterCount = text.replaceAll(" ", '').length - capitalLetterCount;

    return FragmentListView(
      fragmentTitle: "Teksto statistikos fragmentas",
      fragmentResult: "Teksto ilgis ${text.length.toString()} simbolių\n"
          "Tarp jų yra ${vowelCount.toString()} balsių.\n"
          "Tarp jų yra ${lowerCaseLetterCount.toString()} mažųjų ir ${capitalLetterCount.toString()} didžiųjų raidžių.",
    );
  }

  int _getCountOfLetterAa(String text){
    final int aCount = 'a'.allMatches(text).length;
    final int aCapitalCount = 'A'.allMatches(text).length;
    final int countOfA = aCount + aCapitalCount;
    return countOfA;
  }

  bool _containsLettersAa() => text.contains("A") || text.contains("a");

  int _getCapitalLetterCount(String text) {
    int capitalLetterCount = 0;
    String textEdited = text.replaceAll(" ", '');
    for (int i = 0; i < textEdited.length; i++) {
      if (textEdited[i].toUpperCase() == text[i]) {
        capitalLetterCount++;
      }
    }
    return capitalLetterCount;
  }

  int _getVowelCount() {
    int vowelCount = 0;
    final List<String> ltVowels = ['ė', 'o', 'i', 'y', 'į', 'u', 'ū', 'ų', 'a', 'ą', 'e', 'ę'];

    for (String vowel in ltVowels) {
      vowelCount = vowelCount + vowel.allMatches(text.toLowerCase()).length;
    }
    return vowelCount;
  }
}
