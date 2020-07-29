import 'package:flutter/material.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';

class MyLessonCard extends StatefulWidget {
  MyLessonCard({@required this.lessonInfo});

  final LessonModel lessonInfo;

  @override
  _MyLessonCardState createState() => _MyLessonCardState();
}

class _MyLessonCardState extends State<MyLessonCard> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
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
                    image: widget.lessonInfo.image != null ? widget.lessonInfo.image.image : AssetImage('assets/images/lessons.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 5),
                child: Text(
                  widget.lessonInfo.title,
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'WeblogmaYekan',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
//              Padding(
//                padding: const EdgeInsets.only(right: 15),
//                child: Text(
//                  widget.lessonInfo.grade,
//                  style: TextStyle(
//                    fontSize: 14,
//                    fontFamily: 'WeblogmaYekan',
//                    fontWeight: FontWeight.w400,
//                    color: Colors.grey[500],
//                  ),
//                ),
//              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 25),
                child: Text(
                  widget.lessonInfo.description,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'WeblogmaYekan',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
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

//FiXME : default cover for lessons that does not have image or the image did not download imediatly
//FIXME : description lenght must be shorten and other info opened in another page (container height)