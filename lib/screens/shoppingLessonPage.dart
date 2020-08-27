import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/components/badgeIcon.dart';
import 'package:pishgamv2/components/lessonList.dart';
import 'package:pishgamv2/components/purchaseLessonCard.dart';
import 'package:pishgamv2/components/shoppingCard.dart';
import 'package:pishgamv2/constants/Constants.dart';
import 'package:pishgamv2/dialogs/searchFilterDialoge.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';
import 'package:pishgamv2/screens/shopping_basket.dart';
import 'package:provider/provider.dart';

class ShoppingLessonPage extends StatelessWidget {
  ShoppingLessonViewModel viewModel;
  ShoppingBasketViewModel shoppingBasketViewModel;

  Iterable<Widget> getItemsList(List<LessonModel> itemsList) sync* {
    for (LessonModel item in itemsList) {
      yield PurchaseLessonCard(
        purchaseItem: item,
        onDelete: () {
          shoppingBasketViewModel.removeItem(BasketItem(
            courseName: item.title,
            price: item.amount,
            explanation: item.description,
            lessonId: item.id,
          ));
        },
        onAdd: () {
          shoppingBasketViewModel.addItem(BasketItem(
            courseName: item.title,
            price: item.amount,
            explanation: item.description,
            lessonId: item.id
          ));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    shoppingBasketViewModel = Provider.of<ShoppingBasketViewModel>(context, listen: false);
    return BlocBuilder<HomeBloc, HomeState>(condition: (lastState, thisState) {
      if (thisState is ShoppingLessonInitiallized) return true;
      return false;
    }, builder: (context, state) {
      if (state is ShoppingLessonInitiallized) {
        print('hereee');
        viewModel = state.viewmodel;
        print('sss');
        print(viewModel.lessons.toString());
        return _buildShoppingLessonBody(context);
      } else
        return _buildLoaderScreen();
    });
  }

  Scaffold _buildLoaderScreen() {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]),
          ),
        ),
      ),
    );
  }

  Widget _buildShoppingLessonBody(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'خريد درس',
            style: TextStyle(
              fontFamily: 'vazir',
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: Colors.grey[700],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.black87),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => SearchFilterDialog());
              },
            ),
            Consumer<ShoppingBasketViewModel>(
              builder: (context, sbviewModel, child) {
                print('in badge consumer');
                return BadgeIcon(
                icon: IconButton(
                  iconSize: 25,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChangeNotifierProvider<ShoppingBasketViewModel>.value(
                        value: shoppingBasketViewModel,
                        child: ShoppingBasket(),
                      );
                    }));
                  },
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.grey[700],
                ),
                badgeCount: sbviewModel.count,
              );
              },
            ),
            IconButton(
              iconSize: 25,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
              color: Colors.black54,
            ),
          ],
        ),
        body: viewModel.lessons.isNotEmpty
            ? ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: _definePurchaseLessonLists.toList(),
                  ),
                ),
              )
            : Center(
                child: Text(
                  'درسی موجود نیست :/',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[500],
                  ),
                ),
              ),
      ),
    );
  }

  Iterable<Widget> get _definePurchaseLessonLists sync* {
    List<LessonModel> items = List();
    String lastItemParentId;
    String lastItemParentTitle;
    for (final LessonModel item in viewModel.lessons) {
      if (lastItemParentId == null) {
        items.add(item);
        lastItemParentId = item.parent_id;
        lastItemParentTitle = item.parent_name;
        continue;
      }

      if (lastItemParentId == item.parent_id) {
        items.add(item);
        continue;
      }

      if (lastItemParentId != item.parent_id) {
        yield LessonList(
          title: lastItemParentTitle,
          children: getItemsList(items).toList(),
        );
        items.clear();
        items.add(item);
        lastItemParentId = item.parent_id;
        lastItemParentTitle = item.parent_name;
      }
    }

    if (items.isNotEmpty) {
      yield LessonList(
        title: items[0].parent_name,
        children: getItemsList(items).toList(),
      );
      items.clear();
    }
  }
}

class ShoppingLessonViewModel {
  final List<LessonModel> lessons;

  ShoppingLessonViewModel({@required this.lessons});
}
