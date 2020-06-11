import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/authClass.dart';
import 'package:pishgamv2/screens/setting_screen.dart';
import 'package:pishgamv2/screens/splash_screen.dart';
import 'brain/authBloc.dart';
import 'constants/PishgamTheme.dart';

void main() {
  runApp(PishgamDemo());
  //system chrome is needed
}

class PishgamDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: PTheme,
      home: BlocProvider(
        create: (context) => AuthBloc(Auth()),
          child: SettingScreen(),
      ),
    );
  }
}
