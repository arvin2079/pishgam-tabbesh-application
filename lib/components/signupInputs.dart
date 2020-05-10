import 'package:flutter/material.dart';

class SignupTextInput extends StatelessWidget {
  const SignupTextInput(
      {Key key,
      this.focusNode,
      this.controller,
      this.textInputType,
      this.obscureText = false,
      this.labelText,
      this.errorText,
      this.onEditingComplete})
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;
  final String labelText;
  final String errorText;
  final Function onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          focusNode: focusNode,
          controller: controller,
          keyboardType: textInputType,
          obscureText: obscureText,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            errorText: errorText,
            labelText: labelText,
            labelStyle: TextStyle(
              fontFamily: 'vazir',
              fontWeight: FontWeight.w100,
              fontSize: 16,
              color: Colors.grey[300],
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.yellowAccent[700], width: 2.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[100], width: 1.3),
            ),
          ),
          style: TextStyle(
            fontFamily: 'vazir',
            fontWeight: FontWeight.w100,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
