import 'package:flutter/material.dart';
import 'package:pishgamv2/constants/Constants.dart';

class WaiterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 500,
      backgroundColor: Colors.transparent,
      content: Expanded(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(scaffoldDefaultBackgroundColor),
          ),
        ),
      ),
    );
  }
}