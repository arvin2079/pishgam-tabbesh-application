import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/authClass.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/components/shoppingCard.dart';
import 'package:pishgamv2/constants/Constants.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import 'myLessonsPage.dart';

class ShoppingBasket extends StatefulWidget {
  @override
  _ShoppingBasketState createState() => _ShoppingBasketState();
}

class _ShoppingBasketState extends State<ShoppingBasket> {
  ShoppingBasketViewModel viewModel;
  StreamSubscription _sub;
  HomeBloc _homeBloc;

  Iterable<Widget> get _basketWidgets sync* {
    for (BasketItem item in viewModel.basketItems) {
      yield ShoppingItemCard(
        item: item,
        onDelete: () {
          viewModel.removeItem(item);
        },
      );
    }
    yield SizedBox(height: 15);
  }

  void _payWithZarinpal(BuildContext context) async {
    Auth auth = Auth();
    viewModel.isPaying(true);
    try {
      String link = await auth.payWithZarinpall(viewModel.basketItems);
      if (link != null && await canLaunch(link)) {
        await launch(link);
      } else {
        _homeBloc
            .add(ShowMessage('خطا', 'امکان پرداخت در حال حاظر وجود ندارد'));
      }
    } on PlatformException catch (e) {
      _homeBloc.add(ShowMessage(e.message, e.code));
    } catch (e) {
      print('exception catched in shopping basket');
      print(e.toString());
    }

    await Future.delayed(Duration(seconds: 1));
    viewModel.isPaying(false);
  }

  @override
  void initState() {
    _sub ??= getUriLinksStream().listen((Uri uri) {
      _homeBloc.add(InitializeMyLesson());
      Navigator.popUntil(context, ModalRoute.withName("/home"));
      Future.delayed(Duration(milliseconds: 300));
      Navigator.pushNamed(context, "/mylessons");
      if(_sub != null) _sub.cancel();
    }, onError: (Object err) {
      _homeBloc.add(ShowMessage(
        'خطا',
        '',
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
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
                  if (_sub != null) _sub.cancel();
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
                      builder: (context, shoppingBasketViewModel, child) =>
                          Text(
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
                      builder: (context, shoppingBasketViewModel, child) =>
                          Text(
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
                  child: Consumer<ShoppingBasketViewModel>(
                    builder: (context, shoppingBasketViewModel, child) =>
                        RaisedButton(
                      elevation: 2,
                      color: Colors.lime[500],
                      disabledColor: Colors.grey[400],
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
                      onPressed: !viewModel.isPayingNow && viewModel.count != 0
                          ? () => _payWithZarinpal(context)
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Consumer<ShoppingBasketViewModel>(
                    builder: (context, shoppingbasketViewModel, child) =>
                        RaisedButton(
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
                      onPressed: !viewModel.isPayingNow && viewModel.count != 0
                          ? () {
                              viewModel.clearBasket();
                            }
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<ShoppingBasketViewModel>(
                    builder: (context, shoppingBasketViewModel, child) =>
                        ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: _basketWidgets.toList(),
                      ),
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
  bool _isPayingNow = false;

  bool get isPayingNow => _isPayingNow;

  ShoppingBasketViewModel(this.basketItems);

  void removeItem(BasketItem item) {
    if (basketItems.isEmpty) return;
    basketItems.removeWhere((element) => element.courseName == item.courseName);
    totalPrice -= item.price;
    count--;
    notifyListeners();
  }

  void addItem(BasketItem item) {
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

  void isPaying(bool isPaying) {
    _isPayingNow = isPaying;
    notifyListeners();
  }
}
