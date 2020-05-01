import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:pishgamv2/components/mainMenuSliderCard.dart';
import 'package:pishgamv2/components/round_icon_avatar.dart';
import 'package:pishgamv2/components/round_icon_button.dart';
import 'package:pishgamv2/constants/Constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Alignment _alignment = Alignment(0, 2);
  Alignment _startAlignment = Alignment(0, 2);
  Alignment _finishAlignment = Alignment(0, 9.8);
  Animation<Alignment> _animation;
  AnimationController _controller;

  bool expanded = false;

  List<MainMenuSliderCard> _slidingListItems = <MainMenuSliderCard>[
    // FIXME : if my lessons was empty , my lessons card should not be shown
    MainMenuSliderCard(
      icon: Icons.import_contacts,
      labelText: 'درس های من',
      buttonText: 'مشاهده',
      onPressed: () {},
    ),
    MainMenuSliderCard(
      icon: Icons.shopping_basket,
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
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildBackground(size),
            _buildForeground(size, _radius),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildForeground(Size size, Radius _radius) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          if (_alignment.y > _startAlignment.y)
            _alignment += Alignment(0, details.delta.dy / (size.height / 10));
          else if (_alignment == _startAlignment && details.delta.dy > 0)
            _alignment += Alignment(0, details.delta.dy / (size.height / 10));
          else if (_alignment.y < _startAlignment.y)
            _alignment = _startAlignment;
        });
      },
      onVerticalDragDown: (details) {
        _controller.stop();
      },
      onVerticalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy > 0 || _alignment.y > 7.2)
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
              Text('منو کاربری'),
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
    );
  }

  Padding _buildBackground(Size size) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Container(
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
          Container(
            padding: EdgeInsets.all(10),
            width: size.width - 20,
            height: 191,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6.0,
                  // has the effect of softening the shadow
                  spreadRadius: 0.0,
                  // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    3.0, // vertical, move down 10
                  ),
                ),
              ],
//              gradient: LinearGradient(
//                begin: Alignment.topCenter,
//                end: Alignment.bottomCenter,
//                colors: <Color>[
////                  Colors.red,
////                  Colors.green,
////                  Colors.purpleAccent,
//                  Colors.orange,
//                  scaffoldDefaultBackgroundColor,
//                  Colors.white,
//                ],
//              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'مانده تا شروع کلاس',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'vazir',
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
                Text(
                  'نام کلاس',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'vazir',
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w100,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                SlideCountdownClock(
                  duration: Duration(days: 20),
                  slideDirection: SlideDirection.Up,
                  separator: ":",
                  tightLabel: true,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  textStyle: TextStyle(
                    fontSize: 40,
                    fontFamily: 'fredricka',
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'روز',
                      ),
                    ),
                    Text(
                      'ساعت',
                    ),
                    Text(
                      'دقیقه',
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'ثانیه',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RoundIconButton(
                      backgroundColor: Colors.white,
                      icon: Icons.settings,
                      iconColor: Colors.black54,
                      iconSize: 30,
                      buttonSize: 55,
                      elevation: 5,
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'تنظیمات',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    RoundIconButton(
                      backgroundColor: Colors.white,
                      icon: Icons.exit_to_app,
                      iconColor: Colors.black54,
                      iconSize: 30,
                      buttonSize: 55,
                      elevation: 5,
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'خروج از حساب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    RoundIconButton(
                      backgroundColor: Colors.white,
                      icon: Icons.group,
                      iconColor: Colors.black54,
                      iconSize: 30,
                      buttonSize: 55,
                      elevation: 5,
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'درباره ما',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
