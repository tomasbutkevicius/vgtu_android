import 'package:flutter/material.dart';

import 'function_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage('Flutter Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  List<Widget> _tabList = [
    FunctionView(listOfXValues: [1, 2, 3, 4, 5],),
    FunctionView(listOfXValues: [5,6,8,4,9],),
    FunctionView(listOfXValues: [0, 13, 44, 45],),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toUpperCase()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });

          _tabController.animateTo(_currentIndex);
        },
        items: [
          BottomNavigationBarItem(title: Text("Graph 1"), icon: Icon(Icons.calculate)),
          BottomNavigationBarItem(title: Text("Graph 2"), icon: Icon(Icons.calculate)),
          BottomNavigationBarItem(title: Text("Graph 3"), icon: Icon(Icons.calculate))
        ],
      ),
    );
  }
}
