import 'package:flutter/material.dart';
import 'package:pishgamv2/constants/Constants.dart';

class SimpleAlertDialog extends StatelessWidget {
  const SimpleAlertDialog({this.onPressed, @required this.content, @required this.title});
  final String content;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: DialogShape,
      title: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: 'vazir',
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        content,
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
              if(onPressed != null) onPressed();
            },
            color: Colors.grey[700],
            shape: DialogShape,
          ),
        ),
      ],
    );
  }
}
