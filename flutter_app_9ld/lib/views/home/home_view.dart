import 'package:flutter/material.dart';
import 'package:flutter_app_9ld/views/home/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel viewModel;

  @override
  void initState() {
    viewModel = HomeViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Center(
          child: Text("2 kd"),
        ),
        Center(
          child: TextButton(
            onPressed: () => viewModel.resetMd5(),
            child: Text("Resend"),
          ),
        ),
        viewModel.updateValueAvailable ? _valueUpdateBtns() : Container(),
      ],
    );
  }

  Widget _valueUpdateBtns() {
    return Column(
      children: [
        Center(
          child: TextButton(
            onPressed: () => viewModel.updateClick(),
            child: Text("Update data"),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () => viewModel.notUpdateClick(),
            child: Text("Don't update"),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Kontrolinis 2"),
      centerTitle: true,
    );
  }
}
