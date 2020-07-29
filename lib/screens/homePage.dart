import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/authBloc.dart';
import 'package:pishgamv2/brain/authClass.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/components/mainMenuSliderCard.dart';
import 'package:pishgamv2/components/round_icon_button.dart';
import 'package:pishgamv2/constants/Constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';
import 'package:pishgamv2/screens/purchaseLessonPage.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class HomePage extends StatefulWidget {
  HomeViewModel viewModel;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Alignment _alignment = Alignment(0, 2);
  Alignment _startAlignment = Alignment(0, 2);
  Alignment _finishAlignment = Alignment(0, 10.1);
  Animation<Alignment> _animation;
  AnimationController _controller;

  bool timesUp = false;

  HomeBloc _homeBloc;
  AuthBloc _authbloc;
  Auth auth = Auth();

  bool expanded = false;

  List<MainMenuSliderCard> _sliderItems = <MainMenuSliderCard>[];

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _authbloc = BlocProvider.of<AuthBloc>(context);
    _controller.addListener(() {
      setState(() {
        _alignment = _animation.value;
      });
    });
    _sliderItems.add(MainMenuSliderCard(
      icon: Icons.import_contacts,
      labelText: 'درس های من',
      buttonText: 'مشاهده',
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => MyLessons(),
        ));
      },
    ));
    _sliderItems.add(
      MainMenuSliderCard(
        icon: Icons.shopping_basket,
        labelText: 'خرید درس',
        buttonText: 'مشاهده',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (context) => PurchaseLesson(),
          ));
        },
      ),
    );
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
    final Radius _radius = Radius.circular(25);
    return BlocBuilder<HomeBloc, HomeState>(
        // ignore: missing_return
        builder: (context, state) {
      if (state is HomeNotInitialState) {
        _homeBloc.add(InitializeHome());
        return _buildLoaderScreen();
      } else if (state is HomeInitiallized) {
        widget.viewModel = state.viewModel;
        print(widget.viewModel.title);
        print(widget.viewModel.teacher);
        print(widget.viewModel.timeLeft.toString());

        //check if viewmodel is empty or not
        if (widget.viewModel == null) {
          _authbloc.add(
            CatchError(
              message: 'خطا',
              detail: 'اطلاعات شما از سوی سرور دریافت نشد',
            ),
          );
          return _buildLoaderScreen();
        }
        return _buildHomeBody(widget.viewModel, _radius);
      }
//          return _buildHomeBody(_radius);
    });
  }

  Scaffold _buildLoaderScreen() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor:
                AlwaysStoppedAnimation<Color>(scaffoldDefaultBackgroundColor),
          ),
        ),
      ),
    );
  }

  Scaffold _buildHomeBody(HomeViewModel viewModel, Radius _radius) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
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
                              widget.viewModel != null
                                  ? widget.viewModel.name
                                  : '',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'vazir',
                                color: settinPageTitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              widget.viewModel != null
                                  ? widget.viewModel.grade
                                  : '',
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
                        CircleAvatar(
                          child: widget.viewModel == null &&
                                  widget.viewModel.avatar == null
                              ? Icon(Icons.person,
                                  color: Colors.black45, size: 30)
                              : Container(),
                          backgroundColor: widget.viewModel == null &&
                                  widget.viewModel.avatar == null
                              ? Colors.grey[200]
                              : null,
                          backgroundImage: widget.viewModel == null &&
                                  widget.viewModel.avatar == null
                              ? null
                              : widget.viewModel.avatar.image,
                          radius: 35,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: size.width - 20,
                    height: 200,
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.viewModel.timeLeft != null
                              ? 'مانده تا شروع کلاس'
                              : 'امروز فردا کلاس نداری',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'vazir',
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w100,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          widget.viewModel.timeLeft != null
                              ? widget.viewModel.title +
                                  " استاد " +
                                  widget.viewModel.teacher
                              : '__________________',
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
                          duration: widget.viewModel.timeLeft != null
                              ? widget.viewModel.timeLeft
                              : Duration(minutes: 0),
                          slideDirection: SlideDirection.Up,
                          shouldShowDays: true,
                          separator: ":",
                          tightLabel: true,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
//                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          onDone: () {
                            setState(() {
                              timesUp = true;
                            });
                          },
                          textStyle: TextStyle(
                            fontSize: 40,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              'پروفایل',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        timesUp ? RaisedButton(
                          child: Container(
                            child: Text(
                              ':)بزن بریم کلاس',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            // FIXME : get the url of class to join
                          },
                        ) : Container(),
                        Column(
                          children: <Widget>[
                            RoundIconButton(
                              backgroundColor: Colors.white,
                              icon: Icons.exit_to_app,
                              iconColor: Colors.black54,
                              iconSize: 30,
                              buttonSize: 55,
                              elevation: 5,
                              onPressed: () {
                                print('pressed');
                                _authbloc.add(Signout());
                              },
                            ),
                            Text(
                              'خروج',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  if (_alignment.y > _startAlignment.y)
                    _alignment +=
                        Alignment(0, details.delta.dy / (size.height / 10));
                  else if (_alignment == _startAlignment &&
                      details.delta.dy > 0)
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
                if (details.velocity.pixelsPerSecond.dy > 0 ||
                    _alignment.y > 8.5)
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
                    border: Border.all(color: Colors.grey[400]),
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
                          items: _sliderItems,
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
      ),
    );
  }
}

class HomeViewModel {
  final Duration timeLeft;
  final String title;
  final String teacher;
  final String name;
  final String grade;
  final Image avatar;
  final bool isActive;

  HomeViewModel(
      {@required this.isActive,
      @required this.avatar,
      @required this.name,
      @required this.grade,
      @required this.timeLeft,
      @required this.title,
      @required this.teacher});
}
