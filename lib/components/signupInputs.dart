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
      this.enabled,
      this.maxLength,
      this.onEditingComplete,
      this.labelColor = lblColor,
      this.inputColor = Colors.white,
      this.borderColor = brColor,
      this.counterColor = Colors.white})
      : super(key: key);

  static const lblColor = Color(0xFFE0E0E0);
  static const brColor = Color(0xFFF5F5F5);

  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;
  final bool enabled;
  final String labelText;
  final String errorText;
  final int maxLength;
  final Function onEditingComplete;
  final Color labelColor;
  final Color borderColor;
  final Color inputColor;
  final Color counterColor;

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
          maxLength: maxLength,
          keyboardType: textInputType,
          obscureText: obscureText,
          enabled: enabled,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            errorText: errorText,
            labelText: labelText,
            counterStyle: TextStyle(
              color: counterColor,
            ),
            labelStyle: TextStyle(
              fontFamily: 'vazir',
              fontWeight: FontWeight.w100,
              fontSize: 16,
              color: labelColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.yellowAccent[700], width: 2.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1.3),
            ),
          ),
          style: TextStyle(
            fontFamily: 'vazir',
            fontWeight: FontWeight.w100,
            fontSize: 14,
            color: inputColor,
          ),
        ),
      ),
    );
  }
}
