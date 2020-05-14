import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLessons extends StatefulWidget {
  @override
  _MyLessonsState createState() => _MyLessonsState();
}

class _MyLessonsState extends State<MyLessons> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[300],
          title: Text(
            'درس های من',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w100,
              fontFamily: 'vazir',
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              color: Colors.black,
              icon: Icon(Icons.close),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
