import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  CustomDropDownButton({@required this.hint, @required this.items, this.controller});
  final String hint;
  final List<String> items;
  final DropDownController controller;

  @override
  _CustomDropDownButtonState createState() =>
      _CustomDropDownButtonState(hint: hint, items: items);
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  _CustomDropDownButtonState({this.hint, this.items});

  String hint;
  List<String> items;
  String selectedItem;

  @override
  Widget build(BuildContext context) {
    double screenWidth= MediaQuery.of(context).size.width;
    double rp= screenWidth * 0.04;
    double lp= screenWidth * 0.1;
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, right: rp),
      margin: const EdgeInsets.fromLTRB(30, 0, 15, 0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0, style: BorderStyle.solid, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            isDense: true,
            icon: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.expand_more,
                color: Colors.white,
              ),
            ),
            hint: Padding(
              padding: EdgeInsets.only(left: lp),
              child: Text(
                hint,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'vazir',
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
            ),
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((String item) {
                return Text(item,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'vazir',
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ));
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
                child: FittedBox(fit: BoxFit.fitWidth,child: Text(item)),
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
