import 'package:flutter/material.dart';
import 'package:flutter_app_7ld/services/local_notifications.dart';
import 'package:flutter_app_7ld/views/home/home_view.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotifications.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}