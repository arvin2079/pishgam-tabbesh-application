import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pishgamv2/components/badgeIcon.dart';
import 'package:pishgamv2/components/lessonList.dart';
import 'package:pishgamv2/components/purchaseLessonCard.dart';

class PurchaseLesson extends StatefulWidget {
  @override
  _PurchaseLessonState createState() => _PurchaseLessonState();
}

class _PurchaseLessonState extends State<PurchaseLesson> {
  StreamController<int> _countController = StreamController<int>();
  int _count = 0;
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
  ];

  @override
  void dispose() {
    _countController.close();
    super.dispose();
  }

  Iterable<Widget> getItemsList(List<PurchaseItem> itemsList) sync* {
    for (PurchaseItem item in itemsList) {
      yield PurchaseLessonCard(
        purchaseItem: item,
        onDelete: () {
          setState(() {
            _count = _count - 1;
            _countController.sink.add(_count);
            int idx = itemsList.indexWhere((value) {
              if (value == item) return true;
              return false;
            });
            itemsList[idx].isAdded = false;
            itemsList[idx].color = Color(0xFFCDDC39);
            itemsList[idx].child = Text(
              'افزودن به سبد خرید',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontFamily: 'vazir',
                fontSize: 14,
                color: Colors.white,
              ),
            );
          });
        },
        onAdd: () {
          setState(() {
            _count = _count + 1;
            _countController.sink.add(_count);
            int idx = itemsList.indexWhere((value) {
              if (value == item) return true;
              return false;
            });
            itemsList[idx].isAdded = true;
            itemsList[idx].color = Colors.grey[350];
            itemsList[idx].child = Text(
              'حذف از سبد خرید',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontFamily: 'vazir',
                fontSize: 16,
                color: Colors.black,
              ),
            );
          });
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
          automaticallyImplyLeading: false,
          title: Text(
            'خريد درس',
            style: TextStyle(
              fontFamily: 'vazir',
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: Colors.grey[700],
            ),
          ),
          actions: <Widget>[
            StreamBuilder(
              initialData: _count,
              stream: _countController.stream,
              builder: (_, snapshot) => BadgeIcon(
                icon: IconButton(
                  iconSize: 25,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.black,
                ),
                badgeCount: snapshot.data,
              ),
            ),
            IconButton(
              iconSize: 25,
              onPressed: () {
                Navigator.of(context).pop();
              },
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
                    children: getItemsList(items).toList(),
                  ),
                ),
              ),
              LessonList(
                title: 'فیزیک',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: getItemsList(items).toList(),
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
