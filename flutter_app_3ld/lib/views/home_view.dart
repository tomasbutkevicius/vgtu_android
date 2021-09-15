import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _title = "";
  String _faculty = "";
  double _initialRating = 2.0;
  String _dropdownValue = "Pirmadienis";
  bool _toRegister = false;
  DateTime _dateTime = DateTime.now();
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        automaticallyImplyLeading: false,
        title: Text("Lab grafinė vartotojo sąsaja"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Text("Pavadinimas:"),
            title: TextField(
              onChanged: (input) {
                _title = input;
              },
            ),
          ),
          ListTile(
            leading: Text("Fakultetas:"),
            title: TextField(
              onChanged: (input) {
                _faculty = input;
              },
            ),
          ),
          ListTile(
            leading: Text("Sudėtingumas"),
            title: RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print("RATING:");
                print(rating);
                _rating = rating;
              },
            ),
          ),
          ListTile(
            leading: Text("Diena:"),
            title: DropdownButton<String>(
              isExpanded: true,
              value: _dropdownValue,
              icon: Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_downward)),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownValue = newValue!;
                });
              },
              items: <String>['Pirmadienis', 'Antradienis', 'Trečiadienis', 'Ketvirtadienis', 'Penktadienis']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            leading: Text("Laikas:"),
            title: _buildTimePicker(context, _dateTime),
          ),
          _buildRow(
              Text("Registruotis"),
              Switch(
                value: _toRegister,
                onChanged: (bool value) {
                  _toRegister = value;
                  setState(() {});
                },
              )),
          ElevatedButton(
            onPressed: () {
              final DateFormat dateFormatter = DateFormat('jm');
              final snackBar = SnackBar(
                content: Text('Pavadinimas:  $_title\n'
                    'Fakultetas:   $_faculty\n'
                    'Sudėtingumas: $_initialRating\n'
                    'Diena:        $_dropdownValue\n'
                    'Laikas:        ${dateFormatter.format(_dateTime)}\n'
                    'Registruotis: $_toRegister\n'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text(
              "Saugoti",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Row _buildRow(Widget leading, Widget trail) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        leading,
        trail,
      ],
    );
  }

  Widget _buildTimePicker(BuildContext context, DateTime dateTime) {
    return SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        initialDateTime: dateTime,
        mode: CupertinoDatePickerMode.time,
        use24hFormat: false,
        onDateTimeChanged: (dateTime) => setState(() => this._dateTime = dateTime),
      ),
    );
  }
}
