import 'package:flutter/material.dart';
import 'package:pishgamv2/components/customDropDownButton.dart';
import 'package:pishgamv2/components/radioButton.dart';
import 'package:pishgamv2/components/signupInputs.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<String> locations = ['اول', 'دهم', 'دوازدهم'];
  List<String> grades = ['اول', 'دهم', 'دوازدهم'];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final DropDownController _gradeDropDownController = DropDownController();
  final DropDownController _cityDropDownController = DropDownController();
  final RadioGroupController _radioGroupController = RadioGroupController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _familyNameFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          title: Text(
            'تنظیمات',
            style: TextStyle(
              fontFamily: 'vazir',
              fontWeight: FontWeight.w100,
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Card(
          elevation: 3.0,
          margin: EdgeInsets.only(left: 20, right: 20, top: 30),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SignupTextInput(
                  borderColor: Colors.black54,
                  labelColor: Colors.grey[500],
                  inputColor: Colors.black87,
                  labelText: 'نام',
                  textInputType: TextInputType.text,
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                ),
                SignupTextInput(
                  borderColor: Colors.black54,
                  labelColor: Colors.grey[500],
                  inputColor: Colors.black87,
                  labelText: 'نام خانوادگی',
                  focusNode: _familyNameFocusNode,
                  controller: _familyNameController,
                  textInputType: TextInputType.text,
                ),
                SignupTextInput(
                  borderColor: Colors.black54,
                  labelColor: Colors.grey[500],
                  inputColor: Colors.black87,
                  counterColor: Colors.grey[800],
                  labelText: 'شماره موبایل',
                  focusNode: _phoneNumberFocusNode,
                  controller: _phoneNumberController,
                  textInputType: TextInputType.phone,
                  maxLength: 11,
                ),
                SignupTextInput(
                  borderColor: Colors.black54,
                  labelColor: Colors.grey[500],
                  inputColor: Colors.black87,
                  labelText: 'نام کاربری',
                  focusNode: _userNameFocusNode,
                  controller: _userNameController,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 40),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: CustomDropDownButton(
                        color: Colors.grey[600],
                        hint: 'مقطع',
                        items: grades,
                        controller: _gradeDropDownController,
                      ),
                    ),
                    Expanded(
                      child: CustomDropDownButton(
                        color: Colors.grey[600],
                        hint: 'شهر',
                        items: locations,
                        controller: _cityDropDownController,
                      ),
                    ),
                  ],
                ),
                RadioButton(
                  color: Colors.grey[600],
                  txt: 'جنسيت',
                  valueFirst: 1,
                  valueSecond: 2,
                  first: 'پسر',
                  second: 'دختر',
                  controller: _radioGroupController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
