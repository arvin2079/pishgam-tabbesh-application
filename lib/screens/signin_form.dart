import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/validator.dart';
import 'package:pishgamv2/components/signInInputs.dart';
import 'package:pishgamv2/dialogs/alertDialogs.dart';
import 'package:pishgamv2/dialogs/phoneNumGetterDialog.dart';
import 'package:pishgamv2/screens/signup_page.dart';

class SignInForm extends StatefulWidget with CredentioalStringValidator {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _submitEnabled = true;

  void _submit() {
    // TODO : set _submitEnabled to false when futer of authenticatio is in progress
    if (widget.emailValidator.isValid(_emailTextController.text) &&
        widget.passwordValidator.isValid(_passwordTextController.text)) {
      setState(() {
        _submitEnabled = false;
      });
      try {
        // fixme : handel sign in here

      } catch (e) {
        // fixme : handel errors

      } finally {
        setState(() {
          _submitEnabled = true;
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return CredentialError();
        },
      );
    }
  }

  void _onEmailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
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
            //email
            InputTitle(text: 'نام کاربری یا ایمیل'),
            SigninTextInput(
              focusNode: _emailFocusNode,
              controller: _emailTextController,
              onEditingComplete: _onEmailEditingComplete,
              inputType: TextInputType.emailAddress,
              obsecureText: false,
            ),
            //password
            InputTitle(text: 'رمز عبور'),
            SigninTextInput(
              focusNode: _passwordFocusNode,
              controller: _passwordTextController,
              onEditingComplete: _submit,
              inputType: TextInputType.visiblePassword,
              obsecureText: true,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FlatButton(
                color: Colors.yellowAccent[700],
                disabledColor: Colors.black26,
                child: Text(
                  'ورود',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'vazir',
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onPressed: _submitEnabled ? _submit : null,
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
                    onTap: _submitEnabled
                        ? () {
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return PhoneNumGetterDialog();
                            //     }).then((val) {
                            //   // TODO : handel situation that when first dialog confirm or dismiss
                            //   FocusScope.of(context).requestFocus(FocusNode());
                            // });
                            Navigator.of(context).push(
                              MaterialPageRoute<void> (
                                fullscreenDialog: true,
                                builder: (context) => SignUpPage(),
                              )
                            );
                          }
                        : null,
                    child: Text(
                      'ثبت نام کنید',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: _submitEnabled
                            ? Colors.yellowAccent[700]
                            : Colors.black45,
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
      //FIXME : sign in ananymous page fix
//      GestureDetector(
//        onTap: () {
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return AnonymousEntry();
//          }));
//        },
//        child: Center(
//          child: Text(
//            'ورود بدون ثبت نام',
//            textDirection: TextDirection.rtl,
//            style: TextStyle(
//              fontFamily: 'vazir',
//              color: Colors.white,
//              shadows: [Shadow(blurRadius: 10, color: Colors.black54)],
//              fontSize: 18,
//              fontWeight: FontWeight.w900,
//            ),
//          ),
//        ),
//      ),
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
