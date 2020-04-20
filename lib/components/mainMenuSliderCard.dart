import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pishgamv2/constants/Constants.dart';

class MainMenuSliderCard extends StatelessWidget {
  const MainMenuSliderCard({this.onPressed,@required this.icon,@required this.labelText,@required this.buttonText});
  final IconData icon;
  final String labelText;
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0, // has the effect of softening the shadow
            spreadRadius: 0.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              3.0, // vertical, move down 10
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              labelText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: homeIconColor,
                fontFamily: 'vazir',
                fontWeight: FontWeight.w900,
                fontSize: 30
              ),
            ),
          ),
          Icon(
            icon,
            color: homeIconColor,
            size: 200,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: FlatButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'vazir',
                    fontWeight: FontWeight.w500,
                    fontSize: 17
                ),
              ),
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
