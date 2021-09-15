import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_5ld/fragment_view.dart';

class FragmentListView extends StatefulWidget {
  final String fragmentTitle;
  final String fragmentResult;

  const FragmentListView({Key? key, required this.fragmentTitle, required this.fragmentResult}) : super(key: key);

  @override
  State<FragmentListView> createState() => _FragmentListViewState();
}

class _FragmentListViewState extends State<FragmentListView> {
  List<String> sentences = [
    "Tekstas su A raidėmis",
    "Be ieškomo simbolio",
    "Čia yra ieškomas simbolis",
    "Nieko nebus",
    "Rasi ko ieškai"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fragmentai"),
      ),
      body: Column(children: [
        Expanded(child: _buildList()),
        _buildFinderFragment()
      ]),
    );
  }

  Padding _buildFinderFragment() {
    return Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: ListTile(
                title: Text(
                  widget.fragmentTitle,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  widget.fragmentResult,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            )),
      );
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: sentences.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            ListTile(
              title: Text(sentences[index]),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => FragmentView(
                      text: sentences[index],
                    ),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
            ),
            const Divider(color: Colors.black54),
          ]);
        });
  }
}
