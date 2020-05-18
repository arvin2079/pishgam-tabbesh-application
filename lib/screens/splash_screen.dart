import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pishgamv2/brain/authBloc.dart';
import 'package:pishgamv2/screens/homePage.dart';
import 'package:pishgamv2/screens/singin_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  Animation<RelativeRect> _animationPishgamMoveToTop;
  Animation<RelativeRect> _animationTetha;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    initAnimation();

    return BlocBuilder<AuthBloc, AuthState>(
      bloc: authBloc,
      builder: (context, state) {
        if (state.state == ApplicationAuthState.landing && state.user == null) {
          startAnimation().then((value) {
            authBloc.add(AuthEvent(
              event: ApplicationAuthEvent.landing,
            ));
          });
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        PositionedTransition(
                          rect: _animationPishgamMoveToTop,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'پیشـــــــــ',
                                    style: TextStyle(
                                      fontFamily: 'vazir',
                                      fontSize: 41,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'گام',
                                    style: TextStyle(
                                      fontFamily: 'vazir',
                                      fontSize: 41,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.limeAccent[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SpinKitThreeBounce(
                          color: Colors.white,
                          size: 30,
                        ),
                        PositionedTransition(
                          child: Text(
                            'Tetha',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(blurRadius: 10, color: Colors.black54)
                              ],
                              height: 2.7,
                            ),
                          ),
                          rect: _animationTetha,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state.state == ApplicationAuthState.signedOut && state.user == null) {
          return SigninPage();
        } else if (state.state == ApplicationAuthState.signedIn && state.user != null) {
          disposAnimation();
          return HomePage();
        }
        return null;
      },
    );
  }

  void initAnimation() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );

    _animationPishgamMoveToTop = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 19, 300),
      end: RelativeRect.fromLTRB(0, 0, 0, height - 204),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1.0, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    _animationTetha = RelativeRectTween(
      begin: RelativeRect.fromLTRB(width / 2 - 26, height - 88, 0, 0),
      end: RelativeRect.fromLTRB(10, height - 88, 0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1.0, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );
  }

  Future<void> startAnimation() async {
    _controller.forward();
    _controller2.forward();
    await Future.delayed(Duration(seconds: 5));
  }

  void disposAnimation() {
    _controller.dispose();
    _controller2.dispose();
  }
}
