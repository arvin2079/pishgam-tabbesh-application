import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pishgamv2/components/signInInputs.dart';
import 'package:pishgamv2/screens/anonymous_entry.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: BodyColumn(context),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> BodyColumn(BuildContext context) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 60),
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
      Container(
        margin: EdgeInsets.fromLTRB(30, 35, 30, 0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(20.0),
          shape: BoxShape.rectangle,
          color: Colors.white70.withOpacity(0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 40),
            InputTitle(text: 'نام کاربری یا ایمیل'),
            SigninTextInput(
              obsecureText: false,
            ),
            InputTitle(text: 'رمز عبور'),
            SigninTextInput(
              obsecureText: true,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FlatButton(
                color: Colors.yellowAccent[700],
                child: Text(
                  'ورود',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'vazir',
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(
                    'اکانت ندارید؟',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'vazir',
                        fontSize: 11,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'ثبت نام کنید',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.yellowAccent[700],
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AnonymousEntry();
          }));
        },
        child: Center(
          child: Text(
            'ورود بدون ثبت نام',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'vazir',
              color: Colors.white,
              shadows: [Shadow(blurRadius: 10, color: Colors.black54)],
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10),
          child: Text(
            'Tetha',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              shadows: [Shadow(blurRadius: 10, color: Colors.black54)],
              height: 2.7,
            ),
          ),
        ),
      ),
    ];
  }
}
