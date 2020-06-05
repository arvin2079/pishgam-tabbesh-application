import 'package:flutter/material.dart';
import 'package:pishgamv2/constants/Constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {this.focusNode,
      @required this.borderColor,
      this.inputType = TextInputType.text,
      this.controller,
      this.labelText,
      this.errorText});

  final String labelText;
  final String errorText;
  final TextEditingController controller;
  final TextInputType inputType;
  final FocusNode focusNode;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        focusNode: focusNode,
        keyboardType: inputType,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: 'vazir',
          fontWeight: FontWeight.w100,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          labelStyle: TextStyle(color: settingSubTitleColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 2.0),
          ),
        ),
      ),
    );
  }
}
