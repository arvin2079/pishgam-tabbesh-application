import 'package:flutter/material.dart';

class ShoppingItemCard extends StatelessWidget {
  const ShoppingItemCard({@required this.onDelete, @required this.item});
  final BasketItem item;
  final Function onDelete;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.white,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.courseName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontFamily: 'WeblogmaYekan',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'حذف',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'vazir',
                        fontSize: 16,
                      ),
                    ),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
//            Padding(
//              padding: EdgeInsets.only(right: 15, bottom: 18),
//              child: Text(
//                item.grade,
//                style: TextStyle(
//                  color: Colors.grey[700],
//                  fontSize: 14,
//                  fontFamily: 'WeblogmaYekan',
//                  fontWeight: FontWeight.w400,
//                ),
//              ),
//            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text(
                item.explanation,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15,
                  fontFamily: 'WeblogmaYekan',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'قیمت',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontFamily: 'WeblogmaYekan',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    item.price.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'WeblogmaYekan',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BasketItem {
  const BasketItem({this.lessonId, this.courseName, this.explanation, this.price});

  @override
  String toString() {
    return 'BasketItem{courseName: $courseName, lessonId: $lessonId, explanation: $explanation, price: $price}';
  }

  final String courseName;
  final int lessonId;
  final String explanation;
  final double price;
}

// fixme : grades must be gotten from database






