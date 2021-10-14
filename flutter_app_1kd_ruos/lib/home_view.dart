import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_1kd_ruos/second_view.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final String selectedFood;
  final String typedText;
  final TimeOfDay selectedTime;
  final bool showSnackbar;

  const MyHomePage({Key? key, required this.title, required this.selectedFood, required this.typedText, required this.selectedTime, required this.showSnackbar}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _on2ndViewBtnClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondView()),
    );
  }

  @override
  void initState() {
    super.initState();
    if(widget.showSnackbar){
       Future.delayed(Duration.zero,() {
        _showSnackbar(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'HELLO',
            ),
            TextButton(onPressed: _on2ndViewBtnClick, child: Text("Open page 2"),)
          ],
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context) {
    final String snackBarText = "Selected time: ${widget.selectedTime.toString()}\n"
        "Typed text: ${widget.typedText}\n"
        "Selected food: ${widget.selectedFood}\n";

    final snackBar = SnackBar(content: Text(snackBarText));
    
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
