import 'package:flutter/material.dart';
import 'package:pishgamv2/screens/signin_form.dart';
import 'package:pishgamv2/screens/splash_screen.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: SignInForm(),
        ),
      ),
    );
  }
}
