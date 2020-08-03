import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/authBloc.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/components/badgeIcon.dart';
import 'package:pishgamv2/components/lessonList.dart';
import 'package:pishgamv2/components/purchaseLessonCard.dart';
import 'package:pishgamv2/constants/Constants.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';
import 'package:pishgamv2/screens/shopping_cart.dart';

class PurchaseLesson extends StatefulWidget {
  ShoppingLessonViewModel viewModel;

  @override
  _PurchaseLessonState createState() => _PurchaseLessonState();
}

class _PurchaseLessonState extends State<PurchaseLesson> {
  StreamController<int> _countController = StreamController<int>();
  HomeBloc _homeBloc;
  AuthBloc _authbloc;
  int _count = 0;

  @override
  void initState() {
    _authbloc = BlocProvider.of<AuthBloc>(context);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _countController.close();
    super.dispose();
  }

  Iterable<Widget> getItemsList(List<LessonModel> itemsList) sync* {
    for (LessonModel item in itemsList) {
      yield PurchaseLessonCard(
        purchaseItem: item,
        onDelete: () {
          setState(() {
            _count = _count - 1;
            _countController.sink.add(_count);
          });
        },
        onAdd: () {
          setState(() {
            _count = _count + 1;
            _countController.sink.add(_count);
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        // ignore: missing_return
        builder: (context, state) {
      if (state is ShoppingLessonInitiallized) {
        widget.viewModel = state.viewmodel;
        return _buildShoppingLessonBody(context);
      } else
        return _buildLoaderScreen();
    });
  }

  Scaffold _buildLoaderScreen() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor:
                AlwaysStoppedAnimation<Color>(scaffoldDefaultBackgroundColor),
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
            StreamBuilder(
              initialData: _count,
              stream: _countController.stream,
              builder: (_, snapshot) => BadgeIcon(
                icon: IconButton(
                  iconSize: 25,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ShoppingBasket();
                    }));
                  },
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.black,
                ),
                badgeCount: snapshot.data,
              ),
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
        body: widget.viewModel.lessons.isNotEmpty ? ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: _definePurchaseLessonLists.toList(),
            ),
          ),
        ) : Center(
          child: Text(
            'هنوز هیچ درسی ارائه نشده :/',
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
    for (final LessonModel item in widget.viewModel.lessons) {
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
