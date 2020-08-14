import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/screens/splash_screen.dart';
import 'brain/authBloc.dart';
import 'constants/PishgamTheme.dart';

void main() async{
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
          home: LanidngPage(),
        ),
      ),
    );
  }
}
