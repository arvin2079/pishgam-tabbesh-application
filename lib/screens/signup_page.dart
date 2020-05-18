import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pishgamv2/brain/authClass.dart';
import 'package:pishgamv2/brain/validator.dart';
import 'package:pishgamv2/components/customDropDownButton.dart';
import 'package:pishgamv2/components/radioButton.dart';
import 'package:pishgamv2/components/signupInputs.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget with SignupFieldValidator {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<String> location = ['اول', 'دهم', 'دوازدهم'];
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _familyNameFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nationalCodeFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nationalCodeController = TextEditingController();
  String city;
  String grade;
  String gender;

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _familyNameController.dispose();
    _userNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _onNameEditingComplete() {
    if (widget.firstnameValidator.isValid(_nameController.text))
      FocusScope.of(context).requestFocus(_familyNameFocusNode);
  }

  void _onFamilyNameEditingComplete() {
    if (widget.lastnameValidator.isValid(_nameController.text))
      FocusScope.of(context).requestFocus(_userNameFocusNode);
  }

  void _onUserNameEditingComplete() {
    if (widget.usernameValidator.isValid(_userNameController.text))
      FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _onPhoneNumberEditingComplete() {
    if(widget.nationalCodeValidator.isValid(_nationalCodeController.text))
      FocusScope.of(context).requestFocus(_nationalCodeFocusNode);
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
        //fixme : check radio button and dropdowns value
    if (!widget.usernameValidator.isValid(_userNameController.text) ||
        !widget.firstnameValidator.isValid(_nameController.text) ||
        !widget.lastnameValidator.isValid(_familyNameController.text) ||
        !widget.phoneNumberValidator.isValid(_phoneNumberController.text) ||
        !widget.nationalCodeValidator.isValid(_nationalCodeController.text))
        return;
      try {
        final auth = Provider.of<AuthBase>(context);
        auth.signup(
            user: User(
          firstname: _nameController.text,
          lastname: _familyNameController.text,
          username: _userNameController.text,
          gender: gender,
          city: city,
          grades: grade,
          phoneNumber: _phoneNumberController.text,
        ));
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF424242),
      appBar: AppBar(
        elevation: 0,
        title: Text('Page Title'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.white12.withOpacity(0.1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 15),
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'پیشگامی ',
                            style: TextStyle(
                              fontFamily: 'vazir',
                              fontSize: 27,
                              fontWeight: FontWeight.w100,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'شو',
                            style: TextStyle(
                              fontFamily: 'vazir',
                              fontSize: 27,
                              fontWeight: FontWeight.w100,
                              color: Colors.limeAccent[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      color: Colors.black26,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SignupTextInput(
                          labelText: 'نام',
                          focusNode: _nameFocusNode,
                          controller: _nameController,
                          textInputType: TextInputType.text,
                          onEditingComplete: _onNameEditingComplete,
                        ),
                        SignupTextInput(
                          labelText: 'نام خانوادگی',
                          focusNode: _familyNameFocusNode,
                          controller: _familyNameController,
                          textInputType: TextInputType.text,
                          onEditingComplete: _onFamilyNameEditingComplete,
                        ),
                        SignupTextInput(
                          labelText: 'نام کاربری',
                          focusNode: _userNameFocusNode,
                          controller: _userNameController,
                          textInputType: TextInputType.text,
                          onEditingComplete: _onUserNameEditingComplete,
                        ),
                        SignupTextInput(
                          labelText: 'شماره همراه',
                          maxLength: 11,
                          focusNode: _passwordFocusNode,
                          controller: _phoneNumberController,
                          onEditingComplete: _onPhoneNumberEditingComplete,
                          textInputType: TextInputType.text,
                        ),
                        SignupTextInput(
                          labelText: 'کد ملی',
                          focusNode: _nationalCodeFocusNode,
                          controller: _nationalCodeController,
                          textInputType: TextInputType.text,
                          maxLength: 10,
                        ),
                        SizedBox(height: 40),
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomDropDownButton(
                              hint: 'مقطع',
                              items: location,
                            ),
                            CustomDropDownButton(
                              hint: 'شهر',
                              items: location,
                            ),
                          ],
                        ),
                        RadioButton(
                          txt: 'جنسيت',
                          valueFirst: 1,
                          valueSecond: 2,
                          first: 'پسر',
                          second: 'دختر',
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            color: Colors.yellowAccent[700],
                            child: Text(
                              'ثبت',
                              style: TextStyle(
                                fontFamily: 'vazir',
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                                color: Colors.black87,
                              ),
                            ),
                            onPressed: _submit,
                          ),
                        ),
                        SizedBox(height: 35),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// todo : getting value of radio button and dropdown menu
// todo : completing fields and submit method