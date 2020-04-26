import 'package:flutter/material.dart';
import 'package:pishgamv2/constants/Constants.dart';

class CredentialError extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: DialogShape,
      title: Text(
        'ایمیل یا رمز عبور نامعتبر',
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: 'vazir',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        'ایمبل یا رمز عبورت اشکال داشت دوباره چکش کن',
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: 'vazir',
          fontWeight: FontWeight.w100,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: RaisedButton(
            child: Text(
              'باشه',
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
