import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/screens/splash_screen.dart';
import 'alireza/Runner.dart';
import 'brain/authBloc.dart';
import 'constants/Constants.dart';
import 'constants/PishgamTheme.dart';

void main() {
  runApp(PishgamDemo());
  //system chrome is needed
}

class PishgamDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: PTheme,
        home: HomeDemo(),
      ),
    );
  }
}

class HomeDemo extends StatefulWidget {
  @override
  _HomeDemoState createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo>
    with SingleTickerProviderStateMixin {
  Alignment _alignment = Alignment(0, 2);
  Alignment _initAlignment = Alignment(0, 2);
  Animation<Alignment> _animation;
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Radius _radius = Radius.circular(25);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                if (_alignment.y > _initAlignment.y)
                  _alignment += Alignment(0, details.delta.dy / (size.height / 10));
                else if (_alignment == _initAlignment && details.delta.dy > 0)
                  _alignment += Alignment(0, details.delta.dy / (size.height / 10));
                else if (_alignment.y < _initAlignment.y)
                  _alignment = _initAlignment;
              });
            },
            onVerticalDragEnd: (details) {
              print(details.velocity.pixelsPerSecond);
            },
            child: Align(
              alignment: _alignment,
              child: Container(
                width: size.width,
                height: size.height - 100,
                decoration: BoxDecoration(
                  color: cardBackgroudColor,
                  borderRadius:
                      BorderRadius.only(topLeft: _radius, topRight: _radius),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
