import 'package:flutter/material.dart';

class PurchaseLessonCard extends StatefulWidget {
  final Function onAdd;
  final PurchaseItem purchaseItem;
  static bool isAdded = false;

  const PurchaseLessonCard({Key key, this.onAdd, this.purchaseItem})
      : super(key: key);

  @override
  _PurchaseLessonCardState createState() =>
      _PurchaseLessonCardState(onAdd: onAdd, purchaseItem: purchaseItem);
}

class _PurchaseLessonCardState extends State<PurchaseLessonCard> {
  final Function onAdd;
  final PurchaseItem purchaseItem;
  bool isAdded = PurchaseLessonCard.isAdded;

  _PurchaseLessonCardState({this.onAdd, this.purchaseItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
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
                padding: const EdgeInsets.only(right: 15),
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
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 25),
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
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: onAdd,
                    color: isAdded ? Colors.grey[350] : Colors.lime[500],
                    child: isAdded
                        ? Text(
                            'به سبد اضافه شد',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontFamily: 'vazir',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            'افزودن به سبد خرید',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontFamily: 'vazir',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
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

  PurchaseItem({this.imageURL, this.courseName, this.grade, this.explanation});
}
