import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_1kd_ruos/food.dart';
import 'package:flutter_app_1kd_ruos/home_view.dart';
import 'package:flutter_app_1kd_ruos/time_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SecondView extends StatefulWidget {
  const SecondView({Key? key}) : super(key: key);

  @override
  _SecondViewState createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView> {
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _textFieldController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            _buildTextField(),
            _buildTypeAheadField(),
            _buildTimeSelect(context),
            _buildBackBtn(context),
          ]),
        ),
      ),
    );
  }

  TypeAheadField<Food?> _buildTypeAheadField() {
    return TypeAheadField<Food?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._typeAheadController,
        decoration: InputDecoration(labelText: "Food"),
      ),
      suggestionsCallback: (value) {
        return [Food(name: "pizza"), Food(name: "kebab")];
      },
      itemBuilder: (context, Food? suggestion) {
        final food = suggestion!;

        return ListTile(
          title: Text(food.name),
        );
      },
      onSuggestionSelected: (Food? selection) {
        _typeAheadController.text = selection!.name;
      },
    );
  }

  _buildTextField() {
    return TextField(
      controller: _textFieldController,
      decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter something'),
    );
  }

  _buildTimeSelect(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: () async {
          _selectedTime = (await TimeService.timeSelector(context))!;
          print(_selectedTime.hour);
        },
        child: Text("Select time"));
  }

  _buildBackBtn(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: "Home",
                      selectedFood: _typeAheadController.text,
                      typedText: _textFieldController.text,
                      selectedTime: _selectedTime,
                      showSnackbar: true,
                    )),
          );
        },
        child: Text("CONFIRM"));
  }
}
