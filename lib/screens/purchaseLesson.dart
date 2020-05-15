import 'package:flutter/material.dart';
import 'package:pishgamv2/components/lessonsList.dart';
import 'package:pishgamv2/components/purchaseLessonsCard.dart';

class PurchaseLesson extends StatefulWidget {
  @override
  _PurchaseLessonState createState() => _PurchaseLessonState();
}

class _PurchaseLessonState extends State<PurchaseLesson> {
  int counter = 4;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: Text(
            'خريد درس',
            style: TextStyle(
              fontFamily: 'vazir',
              fontWeight: FontWeight.w100,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                IconButton(
                  iconSize: 25,
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.black,
                ),
                Positioned(
                  left: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30)),
                    constraints: BoxConstraints(
                      minWidth: 17,
                      minHeight: 15,
                    ),
                    child: Text(
                      counter.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'vazir',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            IconButton(
              iconSize: 25,
              onPressed: () {},
              icon: Icon(Icons.close),
              color: Colors.black,
            ),
          ],
        ),
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
      ),
    );
  }
}
