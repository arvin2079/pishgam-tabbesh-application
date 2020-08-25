import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/screens/homePage.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';
import 'package:pishgamv2/screens/shoppingLessonPage.dart';
import 'package:pishgamv2/screens/setting_screen.dart';
import 'package:pishgamv2/screens/shopping_basket.dart';
import 'package:pishgamv2/screens/splash_screen.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'brain/authBloc.dart';
import 'constants/PishgamTheme.dart';

void main() async{
  DateTime date = DateTime.now();
  print(date.toString());

  Jalali jalaliDate = Jalali.fromDateTime(date);

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(PishgamDemo());
}

class PishgamDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocProvider(
        create: (context) => AuthBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: PTheme,
          initialRoute: '/',
          routes: {
            '/home': (context) => HomePage(),
            '/mylessons': (context) => MyLessons(),
            '/purchaseLesson': (context) => ShoppingLessonPage(),
            '/shoppingBasket': (context) => ShoppingBasket(),
            '/setting': (context) => SettingScreen(),
          },
          home: LanidngPage(),
        ),
      ),
    );
  }
}
