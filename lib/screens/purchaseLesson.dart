import 'package:flutter/material.dart';
import 'package:pishgamv2/components/lessonsList.dart';
import 'package:pishgamv2/components/purchaseLessonsCard.dart';

class PurchaseLesson extends StatefulWidget {
  @override
  _PurchaseLessonState createState() => _PurchaseLessonState();
}

class _PurchaseLessonState extends State<PurchaseLesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            LessonList(
              title: 'رياضی',
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    PurchaseLessonCard(
                      courseName: 'شیمی دهم',
                      grade: 'پایه دهم',
                      explanation:
                          'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
                      imageURL: 'assets/images/lessons.jpg',
                    ),
                    PurchaseLessonCard(
                      courseName: 'شیمی دهم',
                      grade: 'پایه دهم',
                      explanation:
                          'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
                      imageURL: 'assets/images/lessons.jpg',
                    ),
                    PurchaseLessonCard(
                      courseName: 'شیمی دهم',
                      grade: 'پایه دهم',
                      explanation:
                          'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
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
                    PurchaseLessonCard(
                      courseName: 'شیمی دهم',
                      grade: 'پایه دهم',
                      explanation:
                          'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
                      imageURL: 'assets/images/lessons.jpg',
                    ),
                    PurchaseLessonCard(
                      courseName: 'شیمی دهم',
                      grade: 'پایه دهم',
                      explanation:
                          'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
                      imageURL: 'assets/images/lessons.jpg',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
