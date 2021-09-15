import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordCountView extends StatefulWidget {
  final text;

  const WordCountView({Key? key, this.text}) : super(key: key);

  @override
  _WordCountViewState createState() => _WordCountViewState();
}

class _WordCountViewState extends State<WordCountView> {
  int wordCount = 0;

  @override
  void initState() {
    wordCount = _countWordsInString(widget.text);
    super.initState();
  }

  int _countWordsInString(String text) {
    return text.split(' ').length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("2 Laboratorinis"),
      ),
      body: Container(
          child: Center(
        child: Text(
          "Žodžių skaičius: " + wordCount.toString(),
          style: TextStyle(fontSize: 20),
        ),
      )),
    );
  }
}
