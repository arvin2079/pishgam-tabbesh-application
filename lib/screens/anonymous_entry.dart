import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pishgamv2/components/round_icon_button.dart';
import 'package:pishgamv2/constants/Constants.dart';

class AnonymousEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(right: 15, left: 15, top: 25),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'پیشگام',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 65,
                        color: Colors.white,
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w900,
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(0.0, 4.0),
                              blurRadius: 10.0,
                              color: Colors.black26),
                        ]),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  RoundIconButton(
                    icon: Icons.import_contacts,
                    iconSize: 140,
                    buttonSize: 190,
                    iconColor: iconContentColor,
                    backgroundColor: anomButtonsBackgroundColor,
                    onPressed: () {},
                  ),
                  Text(
                    'دروس موجود',
                    textAlign: TextAlign.center,
                    style: buildItemTextStyle(),
                  ),
                  SizedBox(height: 50),
                  RoundIconButton(
                    icon: Icons.local_library,
                    iconSize: 140,
                    buttonSize: 190,
                    iconColor: iconContentColor,
                    backgroundColor: anomButtonsBackgroundColor,
                    onPressed: () {},
                  ),
                  Text(
                    'درباره پیشگام',
                    textAlign: TextAlign.center,
                    style: buildItemTextStyle(),
                  ),
                  SizedBox(height: 50),
                  RoundIconButton(
                    icon: Icons.group,
                    iconSize: 140,
                    buttonSize: 190,
                    iconColor: iconContentColor,
                    backgroundColor: anomButtonsBackgroundColor,
                    onPressed: () {},
                  ),
                  Text(
                    'درباره ما',
                    textAlign: TextAlign.center,
                    style: buildItemTextStyle(),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle buildItemTextStyle() {
  return TextStyle(
    color: iconContentColor,
    fontFamily: 'vazir',
    fontWeight: FontWeight.w900,
    fontSize: 40.0,
  );
}
