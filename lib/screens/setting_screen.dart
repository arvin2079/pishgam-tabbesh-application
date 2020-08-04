import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pishgamv2/brain/imageUtility.dart';
import 'package:pishgamv2/components/customDropDownButton.dart';
import 'package:pishgamv2/components/radioButton.dart';
import 'package:pishgamv2/components/signupInputs.dart';
import 'package:pishgamv2/dialogs/imageSourceDialog.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<String> locations = ['اول', 'دهم', 'دوازدهم'];
  List<String> grades = ['اول', 'دهم', 'دوازدهم'];
  Image _image;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final DropDownController _gradeDropDownController = DropDownController();
  final DropDownController _cityDropDownController = DropDownController();
  final RadioGroupController _radioGroupController = RadioGroupController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[300],
          title: Text(
            'پروفایل',
            style: TextStyle(
              fontFamily: 'vazir',
              fontWeight: FontWeight.w100,
              fontSize: 25,
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
        body: SingleChildScrollView(
          child: Card(
            elevation: 3.0,
            margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: CircleAvatar(
                        radius: 47,
                        backgroundColor: Colors.grey[50],
                        child: _image == null
                            ? Icon(Icons.person,
                            color: Colors.blueGrey[600], size: 65) : null ,
                      backgroundImage:_image == null ?
                        null : _image.image,
                      ),
                    ),
                    onTap: () => _pickImage(),
                  ),
                ),
                SignupTextInput(
                  borderColor: Colors.black54,
                  labelColor: Colors.grey[500],
                  inputColor: Colors.black87,
                  labelText: 'نام',
                  textInputType: TextInputType.text,
                  controller: _nameController,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                SignupTextInput(
                  borderColor: Colors.black54,
                  labelColor: Colors.grey[500],
                  inputColor: Colors.black87,
                  labelText: 'نام خانوادگی',
                  controller: _familyNameController,
                  textInputType: TextInputType.text,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                SignupTextInput(
                  borderColor: Colors.black54,
                  labelColor: Colors.grey[500],
                  inputColor: Colors.black87,
                  labelText: 'نام کاربری',
                  controller: _userNameController,
                  textInputType: TextInputType.text,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                SignupTextInput(
                  borderColor: Colors.black54,
                  labelColor: Colors.grey[500],
                  inputColor: Colors.black87,
                  counterColor: Colors.grey[800],
                  labelText: 'شماره موبایل',
                  controller: _phoneNumberController,
                  textInputType: TextInputType.phone,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                  maxLength: 10,
                ),
                SizedBox(height: 40),
                Row(
                  textDirection: TextDirection.rtl,
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
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 20),
                      child: RaisedButton(
                        color: Colors.yellowAccent[700],
                        onPressed: (){},
                        child: Text(
                          'ثبت',
                          style: TextStyle(
                            fontFamily: 'vazir',
                            fontWeight: FontWeight.w500 ,
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 20),
                      child: RaisedButton(
                        color: Colors.white,
                        elevation: 0,
                        onPressed: (){},
                        child: Text(
                          'تغییر رمز عبور',
                          style: TextStyle(
                            fontFamily: 'vazir',
                            fontWeight: FontWeight.w500 ,
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    File file = File(pickedFile.path);
    File finalFile = await ImageUtility.compressAndGetFile(file);
    _image = Image.file(finalFile);
    setState(() {});
  }
  void _pickImage() {
    showDialog(
        context: context,
        builder: (context) {
          return ImageSourceDialog(
            onCamera: () => _getImage(ImageSource.camera),
            onGallery: () => _getImage(ImageSource.gallery),
          );
        });
  }
}
