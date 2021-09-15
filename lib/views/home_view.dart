import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2ld/views/word_count_view.dart';
import 'package:share/share.dart';

import 'text_input_view.dart';

class HomeView extends StatelessWidget {
  final String text;

  const HomeView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.indigoAccent, textStyle: const TextStyle(fontSize: 20), fixedSize: Size(300, 50));
    final Widget separator = SizedBox(height: 20);
    final String title = "2 Laboratorinis";

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(title),
      ),
      body: _buildBody(style, context, separator),
    );
  }

  Center _buildBody(ButtonStyle style, BuildContext context, Widget separator) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildButton(
            style,
            context,
            "Įveskite norimą tekstą",
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TextInputView()));
            },
          ),
          separator,
          _buildEnteredText(),
          separator,
          _buildButton(
            style,
            context,
            "Suskaičiuoti žodžius",
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WordCountView(text: text)));
            },
          ),
          separator,
          _buildButton(style, context, "Siųsti tekstą", () {
            _onShare(context);
          }),
        ],
      ),
    );
  }

  ElevatedButton _buildButton(ButtonStyle style, BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: style,
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Container _buildEnteredText() {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  _onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share(text, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
