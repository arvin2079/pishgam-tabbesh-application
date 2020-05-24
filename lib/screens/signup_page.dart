import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/authBloc.dart';
import 'package:pishgamv2/brain/authClass.dart';
import 'package:pishgamv2/brain/validator.dart';
import 'package:pishgamv2/components/customDropDownButton.dart';
import 'package:pishgamv2/components/radioButton.dart';
import 'package:pishgamv2/components/signupInputs.dart';
import 'package:pishgamv2/dialogs/alertDialogs.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget with SignupFieldValidator {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //fixme : grades and location lists
  List<String> locations = ['اول', 'دهم', 'دوازدهم'];
  List<String> grades = ['اول', 'دهم', 'دوازدهم'];
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
  final RadioGroupController _radioGroupController = RadioGroupController();
  final DropDownController _gradeDropDownController = DropDownController();
  final DropDownController _cityDropDownController = DropDownController();

  String city;
  String grade;
  String gender;

  bool _isLoading = false;
  bool _submited = false;

  @override
  void dispose() {
    _nameController.dispose();
    _familyNameController.dispose();
    _userNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _onNameEditingComplete() {
    FocusScope.of(context).requestFocus(_familyNameFocusNode);
  }

  void _onFamilyNameEditingComplete() {
    FocusScope.of(context).requestFocus(_userNameFocusNode);
  }

  void _onUserNameEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _onPhoneNumberEditingComplete() {
    FocusScope.of(context).requestFocus(_nationalCodeFocusNode);
  }

  void _submit() {
    setState(() {
      _isLoading = true;
      _submited = true;
    });

    //fixme : warning
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    try {
      if (!widget.usernameValidator.isValid(_userNameController.text) ||
          !widget.firstnameValidator.isValid(_nameController.text) ||
          !widget.lastnameValidator.isValid(_familyNameController.text) ||
          !widget.phoneNumberValidator.isValid(_phoneNumberController.text) ||
          !widget.nationalCodeValidator.isValid(_nationalCodeController.text) ||
          _radioGroupController.getValue == 0 ||
          _cityDropDownController.getValue == null ||
          _gradeDropDownController.getValue == null) throw Exception;

      authBloc.add(
        DoSignUp(
          user: User(
            firstname: _nameController.text,
            lastname: _familyNameController.text,
            username: _userNameController.text,
            gender: gender,
            city: city,
            grade: grade,
            phoneNumber: _phoneNumberController.text,
          ),
        ),
      );
    } catch (_) {} finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF424242),
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
                      padding: const EdgeInsets.only(left: 30, top: 25),
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'پیشگامی ',
                              style: TextStyle(
                                fontFamily: 'vazir',
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'شو',
                              style: TextStyle(
                                fontFamily: 'vazir',
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10, right: 20),
                            child: Text(
                              'رمز عبور به شماره همراه شما فرستاده خواهد شد.',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'vazir',
                                fontWeight: FontWeight.w100,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SignupTextInput(
                            labelText: 'نام',
                            errorText: _submited &&
                                    !widget.firstnameValidator
                                        .isValid(_nameController.text)
                                ? widget.inValidFirstnameErrorMassage
                                : null,
                            focusNode: _nameFocusNode,
                            controller: _nameController,
                            textInputType: TextInputType.text,
                            onEditingComplete: _onNameEditingComplete,
                          ),
                          SignupTextInput(
                            labelText: 'نام خانوادگی',
                            errorText: _submited &&
                                    !widget.lastnameValidator
                                        .isValid(_familyNameController.text)
                                ? widget.inValidLastnameErrorMassage
                                : null,
                            focusNode: _familyNameFocusNode,
                            controller: _familyNameController,
                            textInputType: TextInputType.text,
                            onEditingComplete: _onFamilyNameEditingComplete,
                          ),
                          SignupTextInput(
                            labelText: 'نام کاربری',
                            errorText: _submited &&
                                    !widget.usernameValidator
                                        .isValid(_userNameController.text)
                                ? widget.inValidUsernameErrorMassage
                                : null,
                            focusNode: _userNameFocusNode,
                            controller: _userNameController,
                            textInputType: TextInputType.text,
                            onEditingComplete: _onUserNameEditingComplete,
                          ),
                          SignupTextInput(
                            labelText: 'شماره همراه',
                            errorText: _submited &&
                                    !widget.phoneNumberValidator
                                        .isValid(_phoneNumberController.text)
                                ? widget.inValidPhoneNumberErrorMassage
                                : null,
                            maxLength: 11,
                            focusNode: _passwordFocusNode,
                            controller: _phoneNumberController,
                            onEditingComplete: _onPhoneNumberEditingComplete,
                            textInputType: TextInputType.text,
                          ),
                          SignupTextInput(
                            labelText: 'کد ملی',
                            errorText: _submited &&
                                    !widget.nationalCodeValidator
                                        .isValid(_nationalCodeController.text)
                                ? widget.invalidNationalCodeErrorMassage
                                : null,
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
                                items: grades,
                                controller: _gradeDropDownController,
                              ),
                              CustomDropDownButton(
                                hint: 'شهر',
                                items: locations,
                                controller: _cityDropDownController,
                              ),
                            ],
                          ),
                          RadioButton(
                            txt: 'جنسيت',
                            valueFirst: 1,
                            valueSecond: 2,
                            first: 'پسر',
                            second: 'دختر',
                            controller: _radioGroupController,
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
      ),
    );
  }
}

// todo : getting value of radio button and dropdown menu
// todo : completing fields and submit method
