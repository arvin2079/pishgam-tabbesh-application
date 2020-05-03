import 'package:flutter/material.dart';
import 'package:pishgamv2/components/shoppingCard.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int totalPrice;
  int count;
  List<ShoppingItemCard> items = List<ShoppingItemCard>();

  @override
  void initState() {
    super.initState();
    items.add(ShoppingItemCard(
      courseName: 'شیمی دهم',
      explanation: 'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
      grade: 'پایه دهم',
      price: 17000,
      onPressed: () {},
    ));
    items.add(ShoppingItemCard(
      courseName: 'شیمی دهم',
      explanation: 'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
      grade: 'پایه دهم',
      price: 19000,
      onPressed: () {},
    ));
    items.add(ShoppingItemCard(
      courseName: 'شیمی دهم',
      explanation: 'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
      grade: 'پایه دهم',
      price: 18000,
      onPressed: () {},
    ));
    items.add(ShoppingItemCard(
      courseName: 'شیمی دهم',
      explanation: 'شیمی دهم با مهدی شهبازی دارنده مدال برنز المپیاد شیمی',
      grade: 'پایه دهم',
      price: 16000,
      onPressed: () {},
    ));
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
                fontWeight: FontWeight.w100,
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                          fontWeight: FontWeight.w100,
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
                            fontWeight: FontWeight.w100,
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
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: 500,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: items[index],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
