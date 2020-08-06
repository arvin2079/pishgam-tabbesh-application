import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  RadioButton(
      {@required this.valueFirst,
      @required this.valueSecond,
      @required this.controller,
      @required this.first,
      @required this.second,
      @required this.txt,
      this.groupValue = 0,
      this.color = Colors.white});

  final int valueFirst;
  final int valueSecond;
  final String first;
  final String second;
  final RadioGroupController controller;
  final String txt;
  final Color color;
  int groupValue;

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 32, 30),
      child: SingleChildScrollView(
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(
              widget.txt,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'IranianSans',
                color: widget.color,
              ),
            ),
            Spacer(),
            Text(
              widget.first,
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'IranianSans',
                color: widget.color,
              ),
            ),
            Radio(
              value: widget.valueFirst,
              groupValue: widget.groupValue,
              activeColor: Colors.yellowAccent[700],
              onChanged: (int value) => radioButtonChecked(value),
            ),
            Text(
              widget.second,
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'IranianSans',
                color: widget.color,
              ),
            ),
            Radio(
              value: widget.valueSecond,
              groupValue: widget.groupValue,
              activeColor: Colors.yellowAccent[700],
              onChanged: (int value) => radioButtonChecked(value),
            ),
          ],
        ),
      ),
    );
  }

  void radioButtonChecked(int value) {
    setState(() {
      widget.controller.value = value;
      widget.groupValue = value;
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
