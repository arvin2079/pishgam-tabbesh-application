import 'package:flutter/material.dart';
import 'package:pishgamv2/components/shoppingCard.dart';

class ShoppingBasket extends StatefulWidget {
  @override
  _ShoppingBasketState createState() => _ShoppingBasketState();
}

class _ShoppingBasketState extends State<ShoppingBasket> {
  int totalPrice;
  int count;
  List<BasketItem> items = List<BasketItem>();
//  List<BasketItem> items = <BasketItem>[
//    BasketItem(
//      courseName: 'اولین کورس',
//      grade: 'اول دبیرستان',
//      explanation: 'توضیحات مربوط به کورس',
//      price: 18000,
//    ),
//    BasketItem(
//      courseName: 'دومین کورس',
//      grade: 'اول دبیرستان',
//      explanation: 'توضیحات مربوط به کورس',
//      price: 18000,
//    ),
//    BasketItem(
//      courseName: 'سومین کورس',
//      grade: 'اول دبیرستان',
//      explanation: 'توضیحات مربوط به کورس',
//      price: 18000,
//    ),
//    BasketItem(
//      courseName: 'چهارمین کورس',
//      grade: 'اول دبیرستان',
//      explanation: 'توضیحات مربوط به کورس',
//      price: 18000,
//    ),
//    BasketItem(
//      courseName: 'پنجمین کورس',
//      grade: 'اول دبیرستان',
//      explanation: 'توضیحات مربوط به کورس',
//      price: 18000,
//    ),
//    BasketItem(
//      courseName: 'شیشمین کورس',
//      grade: 'اول دبیرستان',
//      explanation: 'توضیحات مربوط به کورس',
//      price: 18000,
//    ),
//  ];

  Iterable<Widget> get _basketWidgets sync* {
    for (BasketItem item in items) {
      yield ShoppingItemCard(
        item: item,
        onDelete: () {
          setState(() {
            items.removeWhere((value) {
              if (value == item) return true;
              return false;
            });
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    count = items.length;
    totalPrice = 0;
    for (int i = 0; i < count; i++) {
      totalPrice = totalPrice + items[i].price;
    }

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            elevation: 0,
            title: Text(
              'سبد خرید',
              style: TextStyle(
                fontFamily: 'vazir',
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.black87,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.close),
                color: Colors.black87,
                iconSize: 18,
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'قیمت کل',
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w100,
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      totalPrice.toString(),
                      style: TextStyle(
                        fontFamily: 'WeblogmaYekan',
                        fontWeight: FontWeight.w100,
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'تعداد',
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w100,
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      count.toString(),
                      style: TextStyle(
                        fontFamily: 'WeblogmaYekan',
                        fontWeight: FontWeight.w100,
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 2,
                    color: Colors.lime[500],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'پرداخت',
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                      elevation: 2,
                      color: Colors.black45,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'خالی کردن سبد',
                        style: TextStyle(
                          fontFamily: 'vazir',
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          items.clear();
                        });
                      }),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _basketWidgets.toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
