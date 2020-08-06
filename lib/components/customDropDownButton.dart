import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  CustomDropDownButton(
      {@required this.hint,
      @required this.items,
      this.initialItem,
      this.controller,
      this.color = Colors.white});

  final String hint;
  final String initialItem;
  final List<String> items;
  final DropDownController controller;
  Color color;

  @override
  _CustomDropDownButtonState createState() =>
      _CustomDropDownButtonState(hint: hint, items: items, color: color);
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  _CustomDropDownButtonState({this.hint, this.items, this.color});

  String hint;
  List<String> items;
  String selectedItem;
  Color color;

  @override
  void initState() {
    selectedItem = widget.initialItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.solid, color: color),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true,
            icon: Icon(
              Icons.expand_more,
              color: color,
            ),
            hint: Text(
              hint,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'vazir',
                fontWeight: FontWeight.w100,
                color: color,
              ),
            ),
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((String item) {
                return Text(
                  item,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w100,
                    color: color,
                  ),
                );
              }).toList();
            },
            value: selectedItem,
            onChanged: (newValue) {
              setState(() {
                widget.controller.value = newValue;
                selectedItem = newValue;
              });
            },
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                child: Text(item),
                value: item,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class DropDownController {
  String _value;

  String get getValue => _value;

  set value(String value) {
    _value = value;
  }
}
