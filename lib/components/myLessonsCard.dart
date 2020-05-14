import 'package:flutter/material.dart';

class MyLessonCard extends StatefulWidget {
  MyLessonCard(
      {@required this.imageURL,
      @required this.courseName,
      @required this.grade,
      @required this.explanation});

  final String imageURL;
  final String courseName;
  final String grade;
  final String explanation;

  @override
  _MyLessonCardState createState() => _MyLessonCardState(
      courseName: courseName,
      explanation: explanation,
      grade: grade,
      imageURL: imageURL);
}

class _MyLessonCardState extends State<MyLessonCard> {
  _MyLessonCardState(
      {this.imageURL, this.courseName, this.grade, this.explanation});

  final String imageURL;
  final String courseName;
  final String grade;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        margin: EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    fit: BoxFit.fitWidth,
                    image: AssetImage(imageURL),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 5),
                child: Text(
                  courseName,
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'WeblogmaYekan',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  grade,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'WeblogmaYekan',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 25),
                child: Text(
                  explanation,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'WeblogmaYekan',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
                      child: Text(
                        'دانلود جزوات',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'vazir',
                          color: Colors.white,
                        ),
                      ),
                      elevation: 2,
                      color: Colors.black38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        'شروع کلاس',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'vazir',
                          color: Colors.white,
                        ),
                      ),
                      elevation: 2,
                      color: Colors.lime[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
