import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton(
      {@required this.buttonSize,
        @required this.icon,
        @required this.iconSize,
        @required this.backgroundColor,
        @required this.iconColor,
        this.onPressed});

  final IconData icon;
  final Function onPressed;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  final double buttonSize;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
      fillColor: backgroundColor,
      shape: CircleBorder(),
      constraints:
      BoxConstraints.tightFor(width: buttonSize, height: buttonSize),
      elevation: 5,
      onPressed: onPressed,
    );
  }
}