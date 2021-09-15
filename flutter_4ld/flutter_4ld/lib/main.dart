import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4 Laboratorinis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Leidimai'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController controller;
  late String input;
  late TextEditingController _textController;
  String _initialUrl = "https://www.google.com";

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Row(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  setState(() {
                    controller.goBack();
                  });
                },
                child: Text("Atgal")),
            Expanded(
              child: TextField(
                controller: _textController,
              ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    controller.loadUrl(_textController.text);
                   });
                },
                child: Text("Rodyk")),
          ],
        ),
        Expanded(
          child: WebView(
            initialUrl: _initialUrl,
            onWebViewCreated: (WebViewController webViewController) {
              controller = webViewController;
            },
            onWebResourceError: (err) {
              _displaySnackbar(context, err.toString());
            },
          ),
        ),
      ]),
    );
  }

  void _displaySnackbar(BuildContext context, String meesage) {
    final snackBar = SnackBar(content: Text(meesage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
