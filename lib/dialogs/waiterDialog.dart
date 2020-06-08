import 'package:flutter/material.dart';
import 'package:pishgamv2/constants/Constants.dart';

class WaiterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(scaffoldDefaultBackgroundColor),
        ),
      ),
    );
  }
}