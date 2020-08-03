import 'package:flutter/material.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';

class PurchaseLessonCard extends StatefulWidget {
  final Function onAdd;
  final LessonModel purchaseItem;
  final Function onDelete;

  PurchaseLessonCard({this.onAdd, this.purchaseItem, this.onDelete});

  @override
  _PurchaseLessonCardState createState() => _PurchaseLessonCardState();
}

class _PurchaseLessonCardState extends State<PurchaseLessonCard> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
  MediaQueryData queryData = MediaQuery.of(context);
    return SizedBox(
      width: queryData.size.width - 80,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    fit: BoxFit.fitWidth,
                    image: widget.purchaseItem.image.image,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
                child: Text(
                  widget.purchaseItem.title,
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'WeblogmaYekan',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 8, left: 10),
                child: Text(
                  'قیمت :' + widget.purchaseItem.amount.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 20),
                child: Text(
                  widget.purchaseItem.description,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      isAdded ? widget.onDelete() : widget.onAdd();
                      isAdded = !isAdded;
                    },
                    color: isAdded ? Colors.grey[350] : Color(0xFFCDDC39),
                    child: isAdded
                        ? Text(
                            'حذف از سبد خرید',
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
                              fontWeight: FontWeight.w500,
                              fontFamily: 'vazir',
                              fontSize: 14,
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
