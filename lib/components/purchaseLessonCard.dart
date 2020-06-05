import 'package:flutter/material.dart';

class PurchaseLessonCard extends StatelessWidget {
  final Function onAdd;
  final PurchaseItem purchaseItem;
  final Function onDelete;

  PurchaseLessonCard({this.onAdd, this.purchaseItem, this.onDelete});

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
                    image: AssetImage(purchaseItem.imageURL),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 5),
                child: Text(
                  purchaseItem.courseName,
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'WeblogmaYekan',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(
                  purchaseItem.grade,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'WeblogmaYekan',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6, top: 10, bottom: 20),
                child: Text(
                  purchaseItem.explanation,
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
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: purchaseItem.isAdded ? onDelete : onAdd,
                    color: purchaseItem.color,
                    child: purchaseItem.child,
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

class PurchaseItem {
  final String imageURL;
  final String courseName;
  final String grade;
  final String explanation;
  Color color;
  Widget child;
  bool isAdded;
  static const btnColor = Color(0xFFCDDC39);
  static const btnChild = Text(
    'افزودن به سبد خرید',
    style: TextStyle(
      fontWeight: FontWeight.w100,
      fontFamily: 'vazir',
      fontSize: 14,
      color: Colors.white,
    ),
  );

  PurchaseItem(
      {this.imageURL,
      this.courseName,
      this.grade,
      this.explanation,
      this.color = btnColor,
      this.child = btnChild,
      this.isAdded = false});
}
