import 'package:flutter/material.dart';

class SigninTextInput extends StatelessWidget {
  const SigninTextInput({this.onEditingComplete, this.onChange, this.focusNode, this.controller, this.obsecureText, this.inputType});
  final TextInputType inputType;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool obsecureText;
  final Function onEditingComplete;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
      child: Container(
        height: 45,
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          keyboardType: inputType,
          cursorColor: Colors.black,
          onEditingComplete: onEditingComplete,
          onChanged: onChange,
          toolbarOptions: ToolbarOptions(
            paste: false,
          ),
          obscureText: obsecureText,
          style: TextStyle(
            height: 1.0,
          ),
          decoration: InputDecoration(
//            errorText: 'hello',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            filled: true,
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(
                const Radius.circular(7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class InputTitle extends StatelessWidget {
  const InputTitle({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 60, 5),
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: 'vazir',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
