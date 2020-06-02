import 'package:flutter/material.dart';
import 'package:pishgamv2/components/lessonList.dart';
import 'package:pishgamv2/components/myLessonsCard.dart';

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
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LessonList(
                title: 'ریاضی',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      MyLessonCard(
                        grade: 'پایه دهم',
                        explanation:
                            'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
                        courseName: 'شیمی دهم',
                        imageURL: 'assets/images/lessons.jpg',
                      ),
                      MyLessonCard(
                        grade: 'پایه دهم',
                        explanation:
                            'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
                        courseName: 'شیمی دهم',
                        imageURL: 'assets/images/lessons.jpg',
                      ),
                    ],
                  ),
                ),
              ),
              LessonList(
                title: 'فیزیک',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      MyLessonCard(
                        grade: 'پایه دهم',
                        explanation:
                            'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
                        courseName: 'شیمی دهم',
                        imageURL: 'assets/images/lessons.jpg',
                      ),
                      MyLessonCard(
                        grade: 'پایه دهم',
                        explanation:
                            'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
                        courseName: 'شیمی دهم',
                        imageURL: 'assets/images/lessons.jpg',
                      ),
                    ],
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
