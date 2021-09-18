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
    return _buildHomeView();
  }

  Widget _buildHomeView() {
    return Scaffold(
      appBar: _buildAppBar(context, viewModel.title),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context, String title) {
    return AppBar(
      actions: _buildAppBarActions(context),
      title: Text(title),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [_buildPopupMenu(context)];
  }

  PopupMenuButton<int> _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (item) => viewModel.onSettingsClick(context, item),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 0,
          child: Text("Valandų skirtumas"),
        ),
        const PopupMenuItem(
          value: 1,
          child: Text("Baigti"),
        )
      ],
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            _buildDropdownButton(viewModel.dropdownTitles[0]),
            const SizedBox(
              height: 50,
            ),
            _buildDropdownButton(viewModel.dropdownTitles[1]),
            ValueListenableBuilder<String>(
              valueListenable: viewModel.symbolSpeller,
              builder: (context, value, child) {
                if(value.isEmpty){
                  return const Icon(Icons.cancel);
                }
                return Text(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> _buildDropdownButton(String dropdownTitle) {
    return DropdownButton<String>(
      hint: Text(dropdownTitle, style: TextStyle(color: Colors.black)),
      icon: null,
      iconSize: 0.0,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        viewModel.onDropdownSelection(context, dropdownTitle, newValue!);
      },
      items: <String>[
        viewModel.countSymbolsActionText,
        viewModel.spellSymbolsActionText,
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
