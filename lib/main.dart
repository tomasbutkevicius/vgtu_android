import 'package:flutter/material.dart';
import 'package:flutter_app_2ld/views/home_view.dart';
import 'package:flutter_app_2ld/views/text_input_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomeView(text: 'Įvestas tekstas',),
    );
  }
}
