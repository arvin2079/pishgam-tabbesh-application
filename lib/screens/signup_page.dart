import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pishgamv2/brain/imageUtility.dart';
import 'package:pishgamv2/brain/authBloc.dart';
import 'package:pishgamv2/brain/authClass.dart';
import 'package:pishgamv2/brain/validator.dart';
import 'package:pishgamv2/components/customDropDownButton.dart';
import 'package:pishgamv2/components/radioButton.dart';
import 'package:pishgamv2/components/signupInputs.dart';
import 'package:pishgamv2/dialogs/imageSourceDialog.dart';

class SignUpPage extends StatefulWidget with SignupFieldValidator {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _familyNameFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nationalCodeFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final RadioGroupController _radioGroupController = RadioGroupController();
  final DropDownController _gradeDropDownController = DropDownController();
  final DropDownController _cityDropDownController = DropDownController();

  bool _submited = false;

  AuthBloc authBloc;
  Auth auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = Auth();
    authBloc = BlocProvider.of<AuthBloc>(context);

    if (auth.citiesList == null || auth.gradesList == null || auth.citiesList.isEmpty || auth.gradesList.isEmpty) {
      Navigator.pop(context);
      authBloc.add(CatchError(
        message: 'اشکال در ارتباط با سرور',
        detail: 'برنامه در دریافت اطلاعات دوچار مشکل شده است. لطفا از برنامه خارج شده و بعدا دوباره امتحان کنید',
      ));
    }
  }

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
      _submited = true;
    });

    try {
      print("value of gender >> " + _radioGroupController.getValue.toString());
      if (!widget.usernameValidator.isValid(_userNameController.text) ||
          !widget.firstnameValidator.isValid(_nameController.text) ||
          !widget.lastnameValidator.isValid(_familyNameController.text) ||
          !widget.phoneNumberValidator.isValid(_phoneNumberController.text) ||
          _radioGroupController.getValue == 0 ||
          _cityDropDownController.getValue == null ||
          _gradeDropDownController.getValue == null) throw Exception;

      User user = User(
        firstname: _nameController.text,
        lastname: _familyNameController.text,
        username: _userNameController.text,
        gender: _radioGroupController == 1 ? "True" : "False",
        city: _cityDropDownController.getValue,
        grade: _gradeDropDownController.getValue,
        phoneNumber: _phoneNumberController.text,
      );

      authBloc.add(
        DoSignUp(
          user: user,
        ),
      );

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpLoadingFinished) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
        else if (state is SignUpIsLoadingSta)
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return WaiterDialog();
              });
      },
      child: _buildSignupForm(),
    );
  }

  SafeArea _buildSignupForm() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF424242),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
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
                            maxLength: 10,
                            focusNode: _passwordFocusNode,
                            controller: _phoneNumberController,
                            onEditingComplete: _onPhoneNumberEditingComplete,
                            textInputType: TextInputType.phone,
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: CustomDropDownButton(
                                  hint: 'مقطع',
                                  items: auth.gradesList,
                                  controller: _gradeDropDownController,
                                ),
                              ),
                              Expanded(
                                child: CustomDropDownButton(
                                  hint: 'شهر',
                                  items: auth.citiesList,
                                  controller: _cityDropDownController,
                                ),
                              ),
                            ],
                          ),
                          RadioButton(
                            txt: 'جنسیت',
                            valueFirst: 1,
                            valueSecond: 2,
                            first: 'پسر',
                            second: 'دختر',
                            controller: _radioGroupController,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'رمز عبور به شماره همراه شما فرستاده خواهد شد.',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'vazir',
                                fontWeight: FontWeight.w100,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              'دقت داشته باشید که شماره تلفن خود را بدون صفر و به فرم 9123456789 وارد نمایید.',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'vazir',
                                fontWeight: FontWeight.w100,
                                fontSize: 13,
                              ),
                            ),
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
