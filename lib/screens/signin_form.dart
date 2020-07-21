import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/authBloc.dart';
import 'package:pishgamv2/brain/authClass.dart';
import 'package:pishgamv2/brain/validator.dart';
import 'package:pishgamv2/components/signInInputs.dart';
import 'package:pishgamv2/screens/signup_page.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget with CredentioalStringValidator {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _submit() {
    // ignore: close_sinks
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    if (widget.emailValidator.isValid(_emailTextController.text) &&
        widget.passwordValidator.isValid(_passwordTextController.text)) {
      authBloc.add(DoSignIn(
        username: _emailTextController.text,
        password: _passwordTextController.text,
      ));
    } else {
      authBloc.add(CatchError(
        message: 'ایمیل یا رمز عبور نامعتبر',
        detail: 'لطفا ایمیل و رمز عبور خود را چک کرده و سپس دوباره امتحان کنید',
      ));
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
    // fixme : fix the warning
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
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
              onEditingComplete: () => _onEmailEditingComplete(),
              inputType: TextInputType.text,
              obsecureText: false,
            ),
            //password
            InputTitle(text: 'رمز عبور'),
            SigninTextInput(
              focusNode: _passwordFocusNode,
              controller: _passwordTextController,
              onEditingComplete: () => _submit(),
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
                onPressed: () => _submit(),
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        fullscreenDialog: true,
                        builder: (context) => SignUpPage(),
                      ));
                    },
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
