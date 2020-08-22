import 'package:flutter/material.dart';
import 'package:pishgamv2/components/shoppingCard.dart';
import 'package:provider/provider.dart';

class ShoppingBasket extends StatelessWidget {
  ShoppingBasketViewModel viewModel;

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
    for (BasketItem item in viewModel.basketItems) {
      yield ShoppingItemCard(
        item: item,
        onDelete: () {
          viewModel.removeItem(item);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<ShoppingBasketViewModel>(context, listen: false);

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
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
                color: Colors.black87,
                iconSize: 25,
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
                    Consumer<ShoppingBasketViewModel>(
                      builder: (context, shoppingBasketViewModel, child) => Text(
                        viewModel.totalPrice.toString(),
                        style: TextStyle(
                          fontFamily: 'WeblogmaYekan',
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                          color: Colors.black54,
                        ),
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
                    Consumer<ShoppingBasketViewModel>(
                      builder: (context, shoppingBasketViewModel, child) => Text(
                        viewModel.count.toString(),
                        style: TextStyle(
                          fontFamily: 'WeblogmaYekan',
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                          color: Colors.black54,
                        ),
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
                        viewModel.clearBasket();
                      }),
                ),
                Expanded(
                  child: Consumer<ShoppingBasketViewModel>(
                    builder: (context, shoppingBasketViewModel, child) => SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _basketWidgets.toList(),
                      ),
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

class ShoppingBasketViewModel extends ChangeNotifier {
  final List<BasketItem> basketItems;
  double totalPrice = 0.0;
  int count = 0;

  ShoppingBasketViewModel(this.basketItems);

  void removeItem(BasketItem item) {
    print('remove');
    if (basketItems.isEmpty) return;
    print('remove2');
    basketItems.removeWhere((element) => element.courseName == item.courseName);
    totalPrice -= item.price;
    count--;
    notifyListeners();
  }

  void addItem(BasketItem item) {
    print('addd');
    basketItems.add(item);
    totalPrice += item.price;
    count++;
    notifyListeners();
  }

  void clearBasket() {
    basketItems.clear();
    totalPrice = 0;
    count = 0;
    notifyListeners();
  }
}
