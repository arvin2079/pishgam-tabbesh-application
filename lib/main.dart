import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/authClass.dart';
import 'package:pishgamv2/screens/setting_screen.dart';
import 'package:pishgamv2/screens/signup_page.dart';
import 'package:pishgamv2/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'brain/authBloc.dart';
import 'constants/PishgamTheme.dart';

void main() {
  runApp(PishgamDemo());
  //system chrome is needed
}

class PishgamDemo extends StatelessWidget {
  final Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: PTheme,
      home: MultiProvider(
        providers: [
          Provider<CitiesListHolder>.value(value: auth.citiesList),
          Provider<GradesListHolder>.value(value: auth.gradesList),
        ],
        child: BlocProvider(
          create: (context) => AuthBloc(Auth()),
            child: LanidngPage(),
        ),
      ),
    );
  }
}
