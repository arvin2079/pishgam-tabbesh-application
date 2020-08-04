import 'package:flutter/material.dart';
import 'package:pishgamv2/components/signupInputs.dart';
import 'package:pishgamv2/constants/Constants.dart';

class ChangePassDialog extends StatelessWidget {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passRepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: DialogShape,
      title: Text(
        "انتخاب رمز جدید",
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: 'vazir',
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SignupTextInput(
            borderColor: Colors.black54,
            labelColor: Colors.grey[500],
            inputColor: Colors.black87,
            labelText: 'رمز جدید',
            textInputType: TextInputType.text,
            controller: _passController,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
          ),
          SignupTextInput(
            borderColor: Colors.black54,
            labelColor: Colors.grey[500],
            inputColor: Colors.black87,
            labelText: 'تکرار',
            textInputType: TextInputType.text,
            controller: _passRepController,
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: FlatButton(
            color: Colors.transparent,
            child: Text(
              'انصراف',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'vazir',
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: RaisedButton(
            child: Text(
              'ثبت',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'vazir',
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.grey[700],
            shape: DialogShape,
          ),
        ),
      ],
    );
  }
}

class WaiterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(scaffoldDefaultBackgroundColor),
        ),
      ),
    );
  }
}
