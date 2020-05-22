import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  BadgeIcon({
    this.icon,
    this.badgeCount = 0,
    this.badgeColor = Colors.red,
  });
  final Widget icon;
  final int badgeCount;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      icon,
      badge(badgeCount),
    ]);
  }

  Widget badge(int count) => Positioned(
        left: 5,
        child: Container(
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(30),
          ),
          constraints: BoxConstraints(
            minWidth: 17,
            minHeight: 15,
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w100,
              fontFamily: 'vazir',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
