import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/components/lessonList.dart';
import 'package:pishgamv2/components/myLessonsCard.dart';
import 'package:pishgamv2/constants/Constants.dart';

class MyLessons extends StatefulWidget {
  MyLessonsViewModel viewModel;

  @override
  _MyLessonsState createState() => _MyLessonsState();
}

class _MyLessonsState extends State<MyLessons> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      // ignore: missing_return
        builder: (context, state) {
          if (state is MyLessonsInitiallized) {
            widget.viewModel = state.viewModel;
            return _buildMyLessonsBody(context);
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

  Iterable<Widget> getItemsList(List<LessonModel> itemsList) sync* {
    for (LessonModel item in itemsList) {
      yield MyLessonCard(
        lessonInfo: item,
      );
    }
  }

  Iterable<Widget> get _defineMyLessonList sync* {
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

  Directionality _buildMyLessonsBody(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[300],
          title: Text(
            'درس های من',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              fontFamily: 'vazir',
              color: Colors.grey[700],
            ),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              color: Colors.black,
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: widget.viewModel.lessons.isNotEmpty
            ? ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: _defineMyLessonList.toList(),
                  ),
                ),
              )
            : Center(
                child: Text(
                  'هنوز هیچ درسی خریده نشده :/',
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
}

class MyLessonsViewModel {
  final List<LessonModel> lessons;

  MyLessonsViewModel({@required this.lessons});
}

class LessonModel {
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> courseCalendar;
  final Image image;
  final String title;
  final String code;
  final double amount;
  final String teacherName;
  final String description;
  final String parent_id;
  final String parent_name;
  final bool isActive;
  final DateTime firstClass;
  final String url;

  @override
  String toString() {
    return 'LessonModel{startDate: $startDate, endDate: $endDate, courseCalendar: $courseCalendar, image: $image, title: $title, code: $code, amount: $amount, teacherName: $teacherName, description: $description, parent_id: $parent_id, parent_name: $parent_name, isActive: $isActive, firstClass: $firstClass, url: $url}';
  }

  LessonModel(
      {@required this.startDate,
      @required this.endDate,
      this.courseCalendar,
      @required this.image,
      @required this.title,
      @required this.code,
      this.amount,
      @required this.teacherName,
      this.description,
      @required this.parent_id,
      @required this.parent_name,
      this.isActive,
      this.firstClass,
      this.url});
}
