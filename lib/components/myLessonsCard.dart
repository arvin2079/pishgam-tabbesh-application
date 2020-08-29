import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/constants/calender_convert.dart';
import 'package:pishgamv2/screens/Mylessons_files_screen.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';
import 'package:url_launcher/url_launcher.dart';

class MyLessonCard extends StatefulWidget {
  MyLessonCard({@required this.lessonInfo});

  final LessonModel lessonInfo;

  @override
  _MyLessonCardState createState() => _MyLessonCardState();
}

class _MyLessonCardState extends State<MyLessonCard> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.lessonInfo.firstClass);
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
                  child: FadeInImage(
                    fit: BoxFit.fitWidth,
                    placeholder: Image.asset("assets/images/user.jpg").image,
                    image: widget.lessonInfo.image.image
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15,
                    right: contentPaddingHoriz,
                    left: contentPaddingHoriz),
                child: Text(
                  widget.lessonInfo.title +
                      " استاد " +
                      widget.lessonInfo.teacherName,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: contentPaddingHoriz- 5),
//                child: Text(
//                  widget.lessonInfo.description != null
//                      ? widget.lessonInfo.description
//                      : '',
//                  style: TextStyle(
//                    fontSize: 16,
//                    fontFamily: 'vazir',
//                    fontWeight: FontWeight.w100,
//                    color: Colors.grey[600],
//                  ),
//                ),
                child: Html(
                  data: widget.lessonInfo.description,
                  onLinkTap: (link) async{
                    if (link != null && await canLaunch(link)) {
                    await launch(link);
                    } else {
                    _homeBloc
                        .add(ShowMessage('خطا', 'در حال حاضر امکان باز شدن این لینک وجود ندارد'));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: contentPaddingHoriz),
                child: Text(
                  'زمان شروع دوره :\n' +
                      widget.lessonInfo.startDate.day.toString() +
                      " " +
                      convertMonth(widget.lessonInfo.startDate.month) +
                      " " +
                      widget.lessonInfo.startDate.year.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: contentPaddingHoriz),
                child: Text(
                  'زمان پایان دوره :\n' +
                      widget.lessonInfo.endDate.day.toString() +
                      " " +
                      convertMonth(widget.lessonInfo.endDate.month) +
                      " " +
                      widget.lessonInfo.endDate.year.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              widget.lessonInfo.firstClass != null
                  ? Padding(
                      padding:
                          const EdgeInsets.only(right: contentPaddingHoriz),
                      child: Text(
                        'زمان شروع اولین کلاس :\n' +
                            widget.lessonInfo.firstClass.day.toString() +
                            " " +
                            convertMonth(widget.lessonInfo.firstClass.month) +
                            " " +
                            widget.lessonInfo.firstClass.year.toString(),
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
                padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 15,
                    right: contentPaddingHoriz,
                    left: contentPaddingHoriz),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        _homeBloc
                            .add(InitializeLessonFiles(widget.lessonInfo.code));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MylessonFiles()));
                      },
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: Text(
                        'دانلود جزوات',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'vazir',
                          color: Colors.white,
                        ),
                      ),
                      elevation: 2,
                      color: Colors.black38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: RaisedButton(
                        onPressed: _checkStartTime()
                            ? () async {
                                if (await canLaunch(widget.lessonInfo.url)) {
                                  await launch(widget.lessonInfo.url);
                                } else {
                                  _homeBloc.add(ShowMessage('خطا',
                                      'امکان دسترسی به لینک کلاس در حال حاضر وجود ندارد'));
                                }
                              }
                            : null,
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Text(
                          'شروع',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'vazir',
                            color: Colors.white,
                          ),
                        ),
                        elevation: 2,
                        color: Colors.lime[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _checkStartTime() {
    if (widget.lessonInfo.firstClass == null) {
      return false;
    }
    if (widget.lessonInfo.isActive &&
        widget.lessonInfo.url != null &&
        widget.lessonInfo.url.isNotEmpty)
      return true;
    else {
      if (widget.lessonInfo.firstClass.toDateTime().difference(DateTime.now()) <
          Duration(days: 2)) {
        Future.delayed(widget.lessonInfo.firstClass
                .toDateTime()
                .difference(DateTime.now()))
            .whenComplete(() {
          _homeBloc.add(InitializeMyLesson());
        });
        return false;
      } else {
        return false;
      }
    }
  }
}

//FiXME : default cover for lessons that does not have image or the image did not download imediatly
//FIXME : description lenght must be shorten and other info opened in another page (container height)
