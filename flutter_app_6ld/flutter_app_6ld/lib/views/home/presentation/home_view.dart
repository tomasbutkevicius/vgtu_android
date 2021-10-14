import 'package:flutter/material.dart';
import 'package:flutter_app_6ld/views/home/data/home_viewmodel.dart';

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
    return _buildHomeView(context);
  }

  Widget _buildHomeView(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, viewModel.title),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            _buildOutputField(context),
            SizedBox(height: 50,),
            
            _buildListenerForDateCompare(context),
            SizedBox(height: 50,),

            _buildListenerForRandomNum(context),
            SizedBox(height: 50,),

            _buildDateBtn(context),
            SizedBox(height: 50,),

            _buildStopRandomNumBtn(context),
            SizedBox(height: 50,),

            _buildStartRandomNumBtn(context),
            SizedBox(height: 50,),
            _buildStopAllBtn(context)
          ],
        ),
      ),
    );
  }

  _buildStopAllBtn(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: () => viewModel.handleExit(),
        child: Text("STOP"));
  }

  _buildStartRandomNumBtn(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: () => viewModel.runRandomNumEverySecond(false),
        child: Text("Start random numbers"));
  }

  _buildStopRandomNumBtn(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: () => viewModel.stopRandomNumGen(),
        child: Text("Stop random numbers"));
  }

  _buildDateBtn(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: () => viewModel.dateBtnClick(context),
        child: Text("Select Date"));
  }

  Widget _buildOutputField(BuildContext context) {
    return Text(viewModel.outputFieldText);
  }

  Widget _buildListenerForDateCompare(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: viewModel.daysUntilSelectedDateText,
      builder: (context, value, child) {
        if(value.isEmpty){
          return const Text("");
        }
        return Text(value);
      },
    );
  }

  Widget _buildListenerForRandomNum(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: viewModel.randomNumber,
      builder: (context, value, child) {
        if(value.isEmpty){
          return const Text("");
        }
        return Text(value);
      },
    );
  }
}
