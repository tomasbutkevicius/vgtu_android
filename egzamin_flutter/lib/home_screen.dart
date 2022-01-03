import 'package:egzamin_flutter/services/email_service.dart';
import 'package:egzamin_flutter/services/file_service.dart';
import 'package:egzamin_flutter/second_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fileReadInfo = "";
  bool showAbout = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Meniu'),
            ),
            ListTile(
              title: const Text('Apie programa'),
              onTap: () {
                setState(() {
                  showAbout = !showAbout;
                });

              },
            ),
            ListTile(
              title: const Text('Uzverti programa'),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
            showAbout ? Text("Tai programa ismaniuju irenginiu egzaminui") : SizedBox.shrink(),
          ],
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 1,
          ),
          TextButton(
            onPressed: () => _navigateToSecond(context),
            child: Text("Ivesti informacija"),
          ),
          TextButton(
            onPressed: () => _updateData(),
            child: Text("Nuskaityti informacija"),
          ),
          Text("Is failo nuskaityta info:"),
          fileReadInfo.isEmpty ? Text("Nera informacijos") : Text(fileReadInfo),
        ],
      )),
    );
  }

  void _navigateToSecond(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SecondScreen(),
      ),
    );
  }

  Future _updateData() async {
    FileService fileService = FileService();
    String data = await fileService.read();
    setState(() {
      fileReadInfo = data;
    });
    EmailService emailService = EmailService();
    await emailService.sendData(data);
  }
}
