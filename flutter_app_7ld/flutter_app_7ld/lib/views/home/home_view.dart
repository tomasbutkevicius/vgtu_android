import 'package:flutter/material.dart';
import 'package:flutter_app_7ld/services/settings.dart';
import 'package:flutter_app_7ld/views/home/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel viewModel;
  final String notificationSwitchText = "Akumuliatoraus lygio sekimas";

  @override
  void initState() {
    viewModel = HomeViewModel(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.batteryLevelSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('7 LAB'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text(notificationSwitchText),
                    Switch(
                      value: Settings.notificationsEnabled,
                      onChanged: (value) => viewModel.onNotificationSwitch(),
                    )
                  ],
                ),
            ),
        ),
      ),
    );
  }
}
