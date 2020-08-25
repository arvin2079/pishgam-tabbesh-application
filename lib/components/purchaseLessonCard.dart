import 'package:flutter/material.dart';
import 'package:pishgamv2/components/shoppingCard.dart';
import 'package:pishgamv2/constants/calender_convert.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';
import 'package:pishgamv2/screens/shopping_basket.dart';
import 'package:provider/provider.dart';

class PurchaseLessonCard extends StatefulWidget {
  final Function onAdd;
  final LessonModel purchaseItem;
  final Function onDelete;

  PurchaseLessonCard({this.onAdd, this.purchaseItem, this.onDelete});

  @override
  _PurchaseLessonCardState createState() => _PurchaseLessonCardState();
}

class _PurchaseLessonCardState extends State<PurchaseLessonCard> {
  @override
  Widget build(BuildContext context) {
    ShoppingBasketViewModel shoppingBasketViewModel =
        Provider.of<ShoppingBasketViewModel>(context);

    const double contentPaddingHoriz = 12;
    MediaQueryData queryData = MediaQuery.of(context);
    return SizedBox(
      width: queryData.size.width - 50,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        elevation: 5,
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
                padding: const EdgeInsets.only(
                    top: 15,
                    right: contentPaddingHoriz,
                    left: contentPaddingHoriz),
                child: Text(
                  widget.purchaseItem.title +
                      ' استاد ' +
                      widget.purchaseItem.teacherName,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: contentPaddingHoriz,
                    top: 2,
                    left: contentPaddingHoriz),
                child: Text(
                  widget.purchaseItem.amount.toString() + ' تومان',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: contentPaddingHoriz, vertical: 5),
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
                padding: const EdgeInsets.only(right: contentPaddingHoriz),
                child: Text(
                  'زمان شروع دوره :\n' +
                      widget.purchaseItem.startDate.day.toString() +
                      " " +
                      convertMonth(widget.purchaseItem.startDate.month) +
                      " " +
                      widget.purchaseItem.startDate.year.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.only(right: contentPaddingHoriz),
                child: Text(
                  'زمان پایان دوره :\n' +
                      widget.purchaseItem.endDate.day.toString() +
                      " " +
                      convertMonth(widget.purchaseItem.endDate.month) +
                      " " +
                      widget.purchaseItem.endDate.year.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.only(right: contentPaddingHoriz),
                child: Text(
                  'زمان کلاس ها :',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              widget.purchaseItem.courseCalendar[0] != null
                  ? Padding(
                      padding:
                          const EdgeInsets.only(right: contentPaddingHoriz),
                      child: Text(
                        ' + ' +
                            widget.purchaseItem.courseCalendar[0].day.toString() +
                            " " +
                            convertMonth(widget.purchaseItem.courseCalendar[0].month) +
                            " " +
                            widget.purchaseItem.courseCalendar[0].year.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'vazir',
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : Container(),
              widget.purchaseItem.courseCalendar[1] != null
                  ? Padding(
                      padding:
                          const EdgeInsets.only(right: contentPaddingHoriz),
                      child: Text(
                        ' + ' +
                            widget.purchaseItem.courseCalendar[1].day.toString() +
                            " " +
                            convertMonth(widget.purchaseItem.courseCalendar[1].month) +
                            " " +
                            widget.purchaseItem.courseCalendar[1].year.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'vazir',
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : Container,
              widget.purchaseItem.courseCalendar[2] != null
                  ? Padding(
                      padding:
                          const EdgeInsets.only(right: contentPaddingHoriz),
                      child: Text(
                        ' + ' +
                            widget.purchaseItem.courseCalendar[2].day.toString() +
                            " " +
                            convertMonth(widget.purchaseItem.courseCalendar[2].month) +
                            " " +
                            widget.purchaseItem.courseCalendar[2].year.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'vazir',
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Consumer<ShoppingBasketViewModel>(
                    builder: (context, viewmodel, child) {
                      bool isAdded = false;
                      for (BasketItem item
                          in shoppingBasketViewModel.basketItems) {
                        if (item.courseName == widget.purchaseItem.title &&
                            item.explanation == widget.purchaseItem.description)
                          isAdded = true;
                      }

                      return FlatButton(
                        onPressed: () {
                          isAdded ? widget.onDelete() : widget.onAdd();
                          setState(() {
                            isAdded = !isAdded;
                          });
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
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
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
