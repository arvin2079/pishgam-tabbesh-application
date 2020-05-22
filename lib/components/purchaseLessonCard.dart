import 'package:flutter/material.dart';

class PurchaseLesson extends StatefulWidget {
  PurchaseLesson(
      {@required this.imageURL,
        @required this.courseName,
        @required this.grade,
        @required this.explanation});

  final String imageURL;
  final String courseName;
  final String grade;
  final String explanation;

  @override
  _PurchaseLessonState createState() => _PurchaseLessonState(
      courseName: courseName,
      explanation: explanation,
      grade: grade,
      imageURL: imageURL);
}

class _PurchaseLessonState extends State<PurchaseLesson> {
  _PurchaseLessonState(
      {@required this.imageURL,
        @required this.courseName,
        @required this.grade,
        @required this.explanation});

  final String imageURL;
  final String courseName;
  final String grade;
  final String explanation;
  bool _isAdded = false;

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
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _isAdded = true;
                      });
                    },
                    color: _isAdded ? Colors.grey[350] : Colors.lime[500],
                    child: _isAdded
                        ? Text(
                      'به سبد اضافه شد',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontFamily: 'vazir',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    )
                        : Text(
                      'افزودن به سبد خرید',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontFamily: 'vazir',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
