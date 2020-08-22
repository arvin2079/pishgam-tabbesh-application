import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/constants/Constants.dart';

class MylessonFiles extends StatefulWidget {
  @override
  _MylessonFilesState createState() => _MylessonFilesState();
}

class _MylessonFilesState extends State<MylessonFiles> {
  MyLessonFilesViewModel viewModel = MyLessonFilesViewModel();
  ReceivePort _port = ReceivePort();

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {
        // TODO : do something with data of listen isolate
      });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    super.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(condition: (lastState, thisState) {
      if (thisState is LessonFilesInitiallized) return true;
      return false;
    }, builder: (context, state) {
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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]),
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
            onPressed: () async {

              String localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
              final savedDir = Directory(localPath);
              bool hasExisted = await savedDir.exists();
              if (!hasExisted) {
                savedDir.create();
              }

              final taskId = await FlutterDownloader.enqueue(
                url: item.url,
                savedDir: savedDir.path,
                showNotification: true, // show download progress in status bar (for Android)
                openFileFromNotification: true, // click on notification to open downloaded file (for Android)
              );
              print(taskId);
            },
          ),
          Divider(thickness: 2),
        ],
      );
    }
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
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
