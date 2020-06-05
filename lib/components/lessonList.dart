import 'package:flutter/material.dart';

class LessonList extends StatelessWidget {
  const LessonList({Key key, this.title, this.child}) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w800,
                        fontSize: 31,
                        color: Colors.grey[700]),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.grey[500],
                      margin: EdgeInsets.fromLTRB(20, 50, 10, 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Flexible(
              fit: FlexFit.loose,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
