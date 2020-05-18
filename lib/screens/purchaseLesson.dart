import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pishgamv2/components/badgeIcon.dart';
import 'package:pishgamv2/components/lessonsList.dart';
import 'package:pishgamv2/components/purchaseLessonsCard.dart';

class PurchaseLesson extends StatefulWidget {
  @override
  _PurchaseLessonState createState() => _PurchaseLessonState();
}

class _PurchaseLessonState extends State<PurchaseLesson> {
  StreamController<int> _countController = StreamController<int>();
  int _count = 0;
  //bool isAdded=false;
  List<PurchaseItem> items = <PurchaseItem>[
    PurchaseItem(
      courseName: 'شیمی دهم',
      grade: 'پایه دهم',
      explanation: 'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
      imageURL: 'assets/images/lessons.jpg',
    ),
    PurchaseItem(
      courseName: 'شیمی دهم',
      grade: 'پایه دهم',
      explanation: 'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
      imageURL: 'assets/images/lessons.jpg',
    ),
    PurchaseItem(
      courseName: 'شیمی دهم',
      grade: 'پایه دهم',
      explanation: 'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
      imageURL: 'assets/images/lessons.jpg',
    )
  ];

  @override
  void dispose() {
    _countController.close();
    super.dispose();
  }

  Iterable<Widget> get _lessonWidgets sync* {
    for (PurchaseItem item in items) {
      yield PurchaseLessonCard(
        purchaseItem: item,
        onAdd: () {
          //isAdded = true;
         // PurchaseLessonCard.isAdded = true;
          _count = _count + 1;
          _countController.sink.add(_count);
        },
      );
    }
  }

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
            StreamBuilder(
              initialData: _count,
              stream: _countController.stream,
              builder: (_, snapshot) => BadgeIcon(
                icon: IconButton(
                  iconSize: 25,
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.black,
                ),
                badgeCount: snapshot.data,
              ),
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
                title: 'ریاضی',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _lessonWidgets.toList(),
                  ),
                ),
              ),
              LessonList(
                title: 'فیزیک',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _lessonWidgets.toList(),
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
