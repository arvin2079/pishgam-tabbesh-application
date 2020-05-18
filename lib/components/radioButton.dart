import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  RadioButton(
      {@required this.valueFirst,
      @required this.valueSecond,
        @required this.controller,
      @required this.first,
      @required this.second,
      @required this.txt});
  final int valueFirst;
  final int valueSecond;
  final String first;
  final String second;
  final RadioGroupController controller;
  final String txt;
  @override
  _RadioButtonState createState() => _RadioButtonState(
      valueFirst: valueFirst,
      valueSecond: valueSecond,
      first: first,
      second: second,
      txt: txt);
}

class _RadioButtonState extends State<RadioButton> {
  _RadioButtonState(
      {@required this.valueFirst,
      @required this.valueSecond,
      @required this.first,
      @required this.second,
      @required this.txt});

  final int valueFirst;
  int groupValue = 0;
  final int valueSecond;
  final String first;
  final String second;
  final String txt;

  int get value => groupValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 32, 30),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            txt,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'IranianSans',
              color: Colors.white,
            ),
          ),
          SizedBox(width: 30),
          Text(
            first,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'IranianSans',
              color: Colors.white,
            ),
          ),
          Radio(
            value: valueFirst,
            groupValue: groupValue,
            activeColor: Colors.yellowAccent[700],
            onChanged: (int value) => radioButtonChecked(value),
          ),
          SizedBox(width: 15),
          Text(
            second,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'IranianSans',
              color: Colors.white,
            ),
          ),
          Radio(
            value: valueSecond,
            groupValue: groupValue,
            activeColor: Colors.yellowAccent[700],
            onChanged: (int value) => radioButtonChecked(value),
          ),
        ],
      ),
    );
  }

  void radioButtonChecked(int value) {
    setState(() {
      widget.controller.value = value;
      groupValue = value;
    });
  }
}

class RadioGroupController {
  int _value = 0;

  set value(int value) {
    _value = value;
  }

  int get getValue => _value;
}
