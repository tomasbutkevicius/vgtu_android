import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

class TextInputView extends StatefulWidget {
  @override
  _TextInputViewState createState() => _TextInputViewState();
}

class _TextInputViewState extends State<TextInputView> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(primary: Colors.indigoAccent, textStyle: const TextStyle(fontSize: 20), fixedSize: Size(300, 50));
  String text = '';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Dalinimosi tekstas:',
                    hintText: 'Įveskite tekstą kurį norite dalintis',
                  ),
                  maxLines: 2,
                  onChanged: (String value) => setState(() {
                    text = value;
                  }),
                ),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeView(
                                  text: text,
                                )));
                  },
                  child: Text("Saugoti"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
