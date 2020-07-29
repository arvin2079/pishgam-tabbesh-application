import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/components/lessonList.dart';
import 'package:pishgamv2/components/myLessonsCard.dart';
import 'package:pishgamv2/constants/Constants.dart';

class MyLessons extends StatefulWidget {
  MyLessonsViewModel _viewModel;

  @override
  _MyLessonsState createState() => _MyLessonsState();
}

class _MyLessonsState extends State<MyLessons> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return _buildMyLessonsBody(context);
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LessonList(
                title: 'ریاضی',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
//                    MyLessonCard(
//                    ),
//                    MyLessonCard(
//                    ),
                    ],
                  ),
                ),
              ),
              LessonList(
                title: 'فیزیک',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
//                    MyLessonCard(
//                    ),
//                    MyLessonCard(
//                    ),
                    ],
                  ),
                ),
              ),
              LessonList(
                title: 'فیزیک',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
//                    MyLessonCard(
//                    ),
//                    MyLessonCard(
//                    ),
                    ],
                  ),
                ),
              ),
              LessonList(
                title: 'فیزیک',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
//                    MyLessonCard(
//                    ),
//                    MyLessonCard(
//                    ),
                    ],
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

class MyLessonsViewModel {
  final Map<String, List<LessonModel>> myLessons;

  MyLessonsViewModel({@required this.myLessons});
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


  @override
  String toString() {
    return 'LessonModel{startDate: $startDate, endDate: $endDate, courseCalendar: $courseCalendar, image: $image, title: $title, code: $code, amount: $amount, teacherName: $teacherName, description: $description, parent_id: $parent_id, parent_name: $parent_name}';
  }

  LessonModel(
      {this.startDate,
      this.endDate,
      this.courseCalendar,
      this.image,
      this.title,
      this.code,
      this.amount,
      this.teacherName,
      this.description,
      this.parent_id,
      this.parent_name});
}
