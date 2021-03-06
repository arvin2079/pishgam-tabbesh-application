import 'package:flutter/cupertino.dart';
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
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 5.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.courseName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontFamily: 'WeblogmaYekan',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red, size: 22),
//                      child: Text(
//                        'حذف',
//                        style: TextStyle(
//                          color: Colors.red,
//                          fontWeight: FontWeight.w500,
//                          fontFamily: 'vazir',
//                          fontSize: 15,
//                        ),
//                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  item.explanation.length < 120 ? item.explanation : item.explanation.substring(0, 120) + "...",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15,
                    fontFamily: 'WeblogmaYekan',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    item.price.toString(),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontFamily: 'WeblogmaYekan',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    ' تومان',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'WeblogmaYekan',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
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






