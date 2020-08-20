import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/brain/imageUtility.dart';
import 'package:pishgamv2/brain/validator.dart';
import 'package:pishgamv2/components/customDropDownButton.dart';
import 'package:pishgamv2/components/radioButton.dart';
import 'package:pishgamv2/components/signupInputs.dart';
import 'package:pishgamv2/constants/Constants.dart';
import 'package:pishgamv2/dialogs/imageSourceDialog.dart';

class SettingScreen extends StatefulWidget {
  EditProfileViewModel viewModel;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with EditProfileValidator {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final DropDownController _gradeDropDownController = DropDownController();
  final DropDownController _cityDropDownController = DropDownController();
  final RadioGroupController _radioGroupController = RadioGroupController();

  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _lastPassController = TextEditingController();
  final TextEditingController _passRepController = TextEditingController();

  HomeBloc _homeBloc;

  bool _propertiesIsFirstTime = true;
  bool _passwordIsFirtstTime = true;
  Image _image;

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  void _propertiesSubmit() {
    try {
      if (!usernameValidator.isValid(_userNameController.text) ||
          !firstnameValidator.isValid(_nameController.text) ||
          !lastnameValidator.isValid(_familyNameController.text))
        throw Exception;

      if (_gradeDropDownController.getValue == null ||
          _gradeDropDownController.getValue.isEmpty ||
          _cityDropDownController.getValue == null ||
          _cityDropDownController.getValue.isEmpty) {
        _homeBloc.add(ShowMessage("توجه",
            "ابتدا از تکمیل بودن تمام مشخصات فرم مشخصات خود اطمینان حاصل کرده و سپس دکمه ثبت را فشار دهید"));
        return;
      }

      if (widget.viewModel.firstname != _nameController.text ||
          widget.viewModel.lastname != _familyNameController.text ||
          widget.viewModel.username != _userNameController.text ||
          widget.viewModel.grade != _gradeDropDownController.getValue ||
          widget.viewModel.city != _cityDropDownController.getValue ||
          widget.viewModel.isBoy != (_radioGroupController.getValue == 1) ||
          _image != null) {
        widget.viewModel.firstname = _nameController.text;
        widget.viewModel.lastname = _familyNameController.text;
        widget.viewModel.username = _userNameController.text;
        widget.viewModel.grade = _gradeDropDownController.getValue;
        widget.viewModel.city = _cityDropDownController.getValue;
        widget.viewModel.isBoy = (_radioGroupController.getValue == 1);

        _homeBloc.add(DoEditeProfile(widget.viewModel));
      } else {
        _homeBloc.add(ShowMessage(
            "نا موفق", "هیچ یک از مشخصات کاربری شما تغییر نکرده است"));
      }
    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }

  void _onChangePassSubmit() {
    try {
      _passwordIsFirtstTime = false;
      if (!passwordValidator.isValid(_passRepController.text) ||
          !passwordValidator.isValid(_lastPassController.text) ||
          !passwordValidator.isValid(_newPassController.text))
        throw Exception();

      if (_newPassController.text.trim() != _passRepController.text.trim()) {
        _homeBloc
            .add(ShowMessage("خطا", "رمز وارد شده با تکرار آن مطابقت ندارد"));
        throw Exception();
      }

      _homeBloc.add(DoChangePassword(
          oldPassword: _lastPassController.text,
          newPassword: _newPassController.text));
    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(condition: (lastState, thisState) {
      if (thisState is EditprofileInitiallied) return true;
      return false;
    }, builder: (context, state) {
      if (state is EditprofileInitiallied) {
        widget.viewModel = state.viewModel;

        if (_propertiesIsFirstTime) {
          _nameController.text = widget.viewModel.firstname;
          _familyNameController.text = widget.viewModel.lastname;
          _userNameController.text = widget.viewModel.username;
          _gradeDropDownController.value = widget.viewModel.grade;
          _cityDropDownController.value = widget.viewModel.city;
          _propertiesIsFirstTime = false;
        }
        return _buildSettingBody(context);
      }
      return _buildLoaderScreen();
    });
  }

  Scaffold _buildLoaderScreen() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor:
                AlwaysStoppedAnimation<Color>(scaffoldDefaultBackgroundColor),
          ),
        ),
      ),
    );
  }

  Directionality _buildSettingBody(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[300],
          title: Text(
            'تنظیمات',
            style: TextStyle(
              fontFamily: 'vazir',
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: Colors.grey[800],
            ),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                _homeBloc.add(InitializeHome());
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'مشخصات',
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 3.0,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          child: CircleAvatar(
                            radius: 47,
                            backgroundColor: Colors.grey[50],
                            child: Icon(
                                    Icons.add_a_photo,
                                    size: 31,
                                    color: widget.viewModel.avatar == null ? Colors.grey[800] : Colors.white,
                                  ),
                            backgroundImage: widget.viewModel.avatar == null
                                ? null
                                : _image == null
                                    ? widget.viewModel.avatar.image
                                    : _image.image,
                          ),
                          onTap: () => _pickImage(),
                        ),
                      ),
                      SignupTextInput(
                        borderColor: Colors.black54,
                        labelColor: Colors.grey[500],
                        inputColor: Colors.black87,
                        labelText: 'نام',
                        errorText:
                            !firstnameValidator.isValid(_nameController.text)
                                ? inValidFirstnameErrorMassage
                                : null,
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
                        errorText: !lastnameValidator
                                .isValid(_familyNameController.text)
                            ? inValidLastnameErrorMassage
                            : null,
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
                        errorText:
                            !usernameValidator.isValid(_userNameController.text)
                                ? inValidUsernameErrorMassage
                                : null,
                        controller: _userNameController,
                        textInputType: TextInputType.text,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
//                      SignupTextInput(
//                        borderColor: Colors.black54,
//                        labelColor: Colors.grey[500],
//                        inputColor: Colors.black87,
//                        counterColor: Colors.grey[800],
//                        labelText: 'شماره موبایل',
//                        errorText: !phoneNumberValidator
//                                .isValid(_phoneNumberController.text)
//                            ? inValidPhoneNumberErrorMassage
//                            : null,
//                        controller: _phoneNumberController,
//                        textInputType: TextInputType.phone,
//                        maxLength: 10,
//                      ),
                      SizedBox(height: 40),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Expanded(
                            child: CustomDropDownButton(
                              color: Colors.grey[600],
                              hint: 'مقطع',
                              initialItem: widget.viewModel.grade,
                              items: widget.viewModel.grades,
                              controller: _gradeDropDownController,
                            ),
                          ),
                          Expanded(
                            child: CustomDropDownButton(
                              color: Colors.grey[600],
                              hint: 'شهر',
                              initialItem: widget.viewModel.city,
                              items: widget.viewModel.cities,
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
                        groupValue: widget.viewModel.isBoy ? 1 : 2,
                        first: 'پسر',
                        second: 'دختر',
                        controller: _radioGroupController,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, bottom: 20),
                          child: RaisedButton(
                            color: Colors.yellowAccent[700],
                            onPressed: _propertiesSubmit,
                            child: Text(
                              'ثبت',
                              style: TextStyle(
                                fontFamily: 'vazir',
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'رمز عبور',
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 3.0,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      SignupTextInput(
                        borderColor: Colors.black54,
                        labelColor: Colors.grey[500],
                        inputColor: Colors.black87,
                        labelText: 'رمز قبلی',
                        errorText: !_passwordIsFirtstTime &&
                                !passwordValidator
                                    .isValid(_lastPassController.text)
                            ? notValidPasswordError
                            : null,
                        textInputType: TextInputType.text,
                        controller: _lastPassController,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      SignupTextInput(
                        borderColor: Colors.black54,
                        labelColor: Colors.grey[500],
                        inputColor: Colors.black87,
                        labelText: 'رمز جدید',
                        errorText: !_passwordIsFirtstTime &&
                                !passwordValidator
                                    .isValid(_newPassController.text)
                            ? notValidPasswordError
                            : null,
                        textInputType: TextInputType.text,
                        controller: _newPassController,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      SignupTextInput(
                        borderColor: Colors.black54,
                        labelColor: Colors.grey[500],
                        inputColor: Colors.black87,
                        labelText: 'تکرار',
                        errorText: !_passwordIsFirtstTime &&
                                !passwordValidator
                                    .isValid(_passRepController.text)
                            ? notValidPasswordError
                            : null,
                        onEditingComplete: _onChangePassSubmit,
                        textInputType: TextInputType.text,
                        controller: _passRepController,
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, bottom: 20),
                          child: RaisedButton(
                            color: Colors.yellowAccent[700],
                            onPressed: _onChangePassSubmit,
                            child: Text(
                              'تغییر رمز عبور',
                              style: TextStyle(
                                fontFamily: 'vazir',
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      File finalFile = await ImageUtility.compressAndGetFile(file);

      _image = Image.file(finalFile);
      List<int> imageBytes = await finalFile.readAsBytes();
      _homeBloc.add(UploadImage(base64Encode(imageBytes),
          file.path.split("/").last.split(".").first));
      setState(() {});
    }
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

class EditProfileViewModel {
  String firstname;
  String lastname;
  String username;
  String grade;
  String city;
  bool isBoy;
  String phoneNumber;
  Image avatar;
  List<String> grades;
  List<String> cities;

  @override
  String toString() {
    return 'EditProfileViewModel{firstname: $firstname, lastname: $lastname, grade: $grade, isBoy: $isBoy, phoneNumber: $phoneNumber, avatar: $avatar, grades: $grades, cities: $cities}';
  }

  EditProfileViewModel(
      {this.firstname,
      this.lastname,
      this.city,
      this.username,
      this.grade,
      this.isBoy,
      this.phoneNumber,
      this.avatar,
      this.grades,
      this.cities});
}
