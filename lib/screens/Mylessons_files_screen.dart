import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/constants/Constants.dart';

class MylessonFiles extends StatelessWidget {
  MyLessonFilesViewModel viewModel = MyLessonFilesViewModel();

//  MyLessonFilesViewModel mock = MyLessonFilesViewModel(
//      courseTitle: 'شیمی دوم دبیرستان',
//      teacher: 'مصطفی رحیم صفوی',
//      docs: <DocumentModel>[
//        DocumentModel(
//            title: "جزوه مربوط به جلسه اول تا بیستم",
//            description:
//                "اینجا پاره ای از توضیحات داده خواهد شد اینجا پاره ای از توضیحات داده خواهد شد اینجا پاره ای از توضیحات داده خواهد شد ",
//            sender: "استاد مصطفی رحیمی",
//            url: "http://192.168.1.5:8000/media/documents/000/setting.png"),
//        DocumentModel(
//            title: "جزوه مربوط به جلسها بیستم",
//            description: "اینجا پاره ای از توضیحات خواهد شد ",
//            sender: "استاد مصطفی رحیمی",
//            url: "http://192.168.1.5:8000/media/documents/000/setting.png"),
//        DocumentModel(
//            title: "ججلسه اول تا بیستم",
//            description:
//                "اینجا پاره ای از توضیحات داده خواهدجا پاره ای از توضیحات داده خواهد شد ",
//            sender: "استاد مصطفی رحیمی",
//            url: "http://192.168.1.5:8000/media/documents/000/setting.png"),
//        DocumentModel(
//            title: "جزوه مربوط به جلسه اول تا بیستم",
//            description:
//            "اینجا پاره ای از توضیحات داده خواهد شد اینجا پاره ای از توضیحات داده خواهد شد اینجا پاره ای از توضیحات داده خواهد شد ",
//            sender: "استاد مصطفی رحیمی",
//            url: "http://192.168.1.5:8000/media/documents/000/setting.png"),
//        DocumentModel(
//            title: "جزوه مربوط به جلسها بیستم",
//            description: "اینجا پاره ای از توضیحات خواهد شد ",
//            sender: "استاد مصطفی رحیمی",
//            url: "http://192.168.1.5:8000/media/documents/000/setting.png"),
//        DocumentModel(
//            title: "ججلسه اول تا بیستم",
//            description:
//            "اینجا پاره ای از توضیحات داده خواهدجا پاره ای از توضیحات داده خواهد شد ",
//            sender: "استاد مصطفی رحیمی",
//            url: "http://192.168.1.5:8000/media/documents/000/setting.png"),
//        DocumentModel(
//            title: "جزوه مربوط به جلسه اول تا بیستم",
//            description:
//            "اینجا پاره ای از توضیحات داده خواهد شد اینجا پاره ای از توضیحات داده خواهد شد اینجا پاره ای از توضیحات داده خواهد شد ",
//            sender: "استاد مصطفی رحیمی",
//            url: "http://192.168.1.5:8000/media/documents/000/setting.png"),
//        DocumentModel(
//            title: "جزوه مربوط به جلسها بیستم",
//            description: "اینجا پاره ای از توضیحات خواهد شد ",
//            sender: "استاد مصطفی رحیمی",
//            url: "http://192.168.1.5:8000/media/documents/000/setting.png"),
//        DocumentModel(
//            title: "ججلسه اول تا بیستم",
//            description:
//            "اینجا پاره ای از توضیحات داده خواهدجا پاره ای از توضیحات داده خواهد شد ",
//            sender: "استاد مصطفی رحیمی",
//            url: "http://192.168.1.5:8000/media/documents/000/setting.png"),
//      ]);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is LessonFilesInitiallized) {
        viewModel = state.viewModel;
        return _buildFilesScreenBody(context);
      }
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
            valueColor:
                AlwaysStoppedAnimation<Color>(Colors.grey[300]),
          ),
        ),
      ),
    );
  }

  Directionality _buildFilesScreenBody(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[300],
          title: viewModel.courseTitle != null
              ? Text(
                  viewModel.courseTitle,
                  style: TextStyle(
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.grey[800],
                  ),
                )
              : Container(),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: viewModel.docs != null && viewModel.docs.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 16,
                        ),
                        viewModel.teacher != null
                            ? Row(
                                children: <Widget>[
                                  Icon(Icons.school, color: Colors.grey[800]),
                                  Text(
                                    "مدرس : " + viewModel.teacher,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800]),
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(height: 20),
                        Column(
                          children: _buildItem(context).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: Align(
                  child: Text(
                    "هیچ فایلی برای دانلود وجود ندارد :/",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                  ),
                ),
              ),
      ),
    );
  }

  Iterable<Widget> _buildItem(BuildContext context) sync* {
    for (DocumentModel item in viewModel.docs) {
      yield Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.attach_file,
                color: Colors.grey[800],
              ),
              Text(
                item.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 3),
          Text(
            item.description,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w100),
          ),
          Text(
            "فرستنده : " + item.sender,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w100),
          ),
          SizedBox(height: 10),
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            icon: Icon(Icons.file_download),
            label: Text("دانلود"),
            color: Colors.white.withOpacity(0.92),
            onPressed: () {},
          ),
          Divider(thickness: 2),
        ],
      );
    }
  }
}

class MyLessonFilesViewModel {
  final String courseTitle;
  final String teacher;
  final List<DocumentModel> docs;

  MyLessonFilesViewModel({this.docs, this.teacher, this.courseTitle});
}

class DocumentModel {
  final String title;
  final String sender;
  final String description;
  final String url;

  @override
  String toString() {
    return 'DocumentModel{title: $title\n, sender: $sender\n, description: $description\n, url: $url}\n';
  }

  DocumentModel({this.title, this.sender, this.description, this.url});
}
