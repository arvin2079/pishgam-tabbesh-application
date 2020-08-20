import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pishgamv2/brain/authClass.dart';
import 'package:pishgamv2/brain/homeBloc.dart';
import 'package:pishgamv2/components/customDropDownButton.dart';
import 'package:pishgamv2/constants/Constants.dart';

class SearchFilterDialog extends StatelessWidget {
  DropDownController _gradeDropDownController = DropDownController();
  DropDownController _teachersDropDownController = DropDownController();
  DropDownController _parentLessonsDropDownController = DropDownController();
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    print(auth.teahcersList.toString());
    print(auth.parentLessonsList.toString());
    print(auth.gradesList.toString());
    return Dialog(
      shape: DialogShape,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomDropDownButton(
                hint: 'مقطع',
                items: auth.gradesList,
                controller: _gradeDropDownController,
                color: Colors.black87,
              ),
              SizedBox(height: 5),
              CustomDropDownButton(
                hint: 'استاد',
                items: auth.teahcersList,
                controller: _teachersDropDownController,
                color: Colors.black87,
              ),
              SizedBox(height: 5),
              CustomDropDownButton(
                hint: 'درس',
                items: auth.parentLessonsList,
                controller: _parentLessonsDropDownController,
                color: Colors.black87,
              ),
//              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: RaisedButton(
                  disabledColor: Colors.grey[300],
                  color: Colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  elevation: 2,
                  child: Text(
                    'انتخاب',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);

                    //FIXME : check if navigator pop does not make any problem
                    Navigator.of(context).pop();
                    _homeBloc.add(InitializeShoppingLesson(
                      teacher: _teachersDropDownController.getValue,
                      grade: _gradeDropDownController.getValue,
                      parentLesson: _parentLessonsDropDownController.getValue,
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
