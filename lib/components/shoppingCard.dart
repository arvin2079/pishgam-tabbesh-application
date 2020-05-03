import 'package:flutter/material.dart';

class ShoppingItemCard extends StatelessWidget {

  const ShoppingItemCard({Key key, this.courseName, this.grade, this.explanation, this.price, this.onPressed}) : super(key: key);

  final String courseName;
  final String grade;
  final String explanation;
  final int price;
  final Function onPressed;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(5),
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
                    courseName,
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
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, bottom: 18),
              child: Text(
                grade,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontFamily: 'WeblogmaYekan',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text(
                explanation,
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
                    price.toString(),
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






