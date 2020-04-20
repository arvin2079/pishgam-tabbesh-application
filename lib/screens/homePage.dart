import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:pishgamv2/components/mainMenuSliderCard.dart';
import 'package:pishgamv2/components/round_icon_avatar.dart';
import 'package:pishgamv2/constants/Constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Alignment _alignment = Alignment(0, 2);
  Alignment _startAlignment = Alignment(0, 2);
  Alignment _finishAlignment = Alignment(0, 7.2);
  Animation<Alignment> _animation;
  AnimationController _controller;

  List<MainMenuSliderCard> _slidingListItems = <MainMenuSliderCard>[
    // FIXME : if my lessons was empty , my lessons card should not be shown
    MainMenuSliderCard(
      icon: Icons.import_contacts,
      labelText: 'درس های من',
      buttonText: 'مشاهده',
      onPressed: () {},
    ),
    MainMenuSliderCard(
      icon: Icons.import_contacts,
      labelText: 'خرید درس',
      buttonText: 'مشاهده',
      onPressed: () {},
    ),
  ];

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      setState(() {
        _alignment = _animation.value;
      });
    });
    super.initState();
  }

  //panel goes down
  void _runForwardAnimation(Offset pixelPerSecond, Size size) {
    _animation = _controller.drive(AlignmentTween(
      begin: _alignment,
      end: _finishAlignment,
    ));

    final unitPerSecondx = pixelPerSecond.dx / (size.width);
    final unitPerSecondy = pixelPerSecond.dy / (size.height);
    final Offset unitperSecond = Offset(unitPerSecondx, unitPerSecondy);
    final unitVelocity = unitperSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, unitVelocity);
    _controller.animateWith(simulation);
  }

  //panel goes up
  void _runBackwardAnimation(Offset pixelPerSecond, Size size) {
    _animation = _controller.drive(AlignmentTween(
      begin: _alignment,
      end: _startAlignment,
    ));

    final unitPerSecondx = pixelPerSecond.dx / (size.width);
    final unitPerSecondy = pixelPerSecond.dy / (size.height);
    final Offset unitperSecond = Offset(unitPerSecondx, unitPerSecondy);
    final unitVelocity = unitperSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, unitVelocity);
    _controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Radius _radius = Radius.circular(25);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: size.width - 20,
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'نام و نام خانوادگی',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'vazir',
                              color: settinPageTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            'پایه تحصیلی',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'vazir',
                              color: settinPageTitleColor,
                              fontWeight: FontWeight.w100,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Avatar(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                if (_alignment.y > _startAlignment.y)
                  _alignment +=
                      Alignment(0, details.delta.dy / (size.height / 10));
                else if (_alignment == _startAlignment && details.delta.dy > 0)
                  _alignment +=
                      Alignment(0, details.delta.dy / (size.height / 10));
                else if (_alignment.y < _startAlignment.y)
                  _alignment = _startAlignment;
              });
            },
            onVerticalDragDown: (details) {
              _controller.stop();
            },
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy > 0 || _alignment.y > 6)
                _runForwardAnimation(details.velocity.pixelsPerSecond, size);
              else
                _runBackwardAnimation(details.velocity.pixelsPerSecond, size);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 3,
                      width: size.width - 200,
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: settingSubtitleIconColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Expanded(
                      child: CarouselSlider(
                        items: _slidingListItems,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        enlargeCenterPage: false,
                        initialPage: 0,
                        height: size.height - 320,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
