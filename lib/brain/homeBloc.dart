import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pishgamv2/screens/homePage.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';
import 'package:pishgamv2/screens/purchaseLessonPage.dart';
import 'package:pishgamv2/screens/setting_screen.dart';

import 'authClass.dart';

//home events
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class ShowMessage extends HomeEvent {
  ShowMessage(this.message, this.detail);
  final String message;
  final String detail;

  @override
  List<Object> get props => null;
}

class DoEditeProfile extends HomeEvent {
  DoEditeProfile(this.result);
  final EditProfileViewModel result;

  @override
  List<Object> get props => null;
}

class DoChangePassword extends HomeEvent {
  DoChangePassword({this.newPassword, this.oldPassword});
  final String oldPassword;
  final String newPassword;

  @override
  List<Object> get props => null;
}

class BreakHomeInitialization extends HomeEvent {
  @override
  List<Object> get props => null;
}

class InitializeEditProfile extends HomeEvent {
  @override
  List<Object> get props => null;
}

class InitializeHome extends HomeEvent {
  @override
  List<Object> get props => null;
}

class InitializeMyLesson extends HomeEvent {
  @override
  List<Object> get props => null;
}

class InitializedShoppingLesson extends HomeEvent {
  InitializedShoppingLesson();

  @override
  List<Object> get props => null;
}

//home states
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitiallized extends HomeState {
  const HomeInitiallized(this.viewModel);

  final HomeViewModel viewModel;

  @override
  List<Object> get props => [Random().nextInt(10000)];
}

class EditprofileInitiallied extends HomeState {
  const EditprofileInitiallied(this.viewModel);

  final EditProfileViewModel viewModel;

  @override
  List<Object> get props => null;
}

class MyLessonsInitiallized extends HomeState {
  MyLessonsInitiallized(this.viewModel);

  final MyLessonsViewModel viewModel;

  @override
  List<Object> get props => [Random().nextInt(10000)];
}

class ShoppingLessonInitiallized extends HomeState {
  ShoppingLessonInitiallized(this.viewmodel);

  final ShoppingLessonViewModel viewmodel;

  @override
  List<Object> get props => null;
}

class HomeNotInitialState extends HomeState {
  @override
  List<Object> get props => null;
}

class ShowMessageState extends HomeState {
  ShowMessageState(this.message, this.detail);
  final String message;
  final String detail;

  @override
  List<Object> get props => [Random().nextInt(10000)];
}

class EditProfLoadingStart extends HomeState {
  @override
  List<Object> get props => [Random().nextInt(10000)];
}

class EditProfLoadingFinish extends HomeState {
  @override
  List<Object> get props => [Random().nextInt(10000)];
}


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Auth auth = Auth();

  @override
  get initialState => HomeNotInitialState();

  @override
  Stream<HomeState> mapEventToState(event) async* {
    if (event is InitializeHome) {
      HomeViewModel viewModel = await auth.initializeHome();
      yield HomeInitiallized(viewModel);
    }

    else if (event is InitializeMyLesson) {
      try {
        MyLessonsViewModel viewModel = await auth.initializeMyLesson();
        yield MyLessonsInitiallized(viewModel);
      } catch (e) {
        print(e.toString());
      }
    }

    else if (event is InitializedShoppingLesson) {
      ShoppingLessonViewModel viewModel = await auth.initializeShoppingLesson();
      yield ShoppingLessonInitiallized(viewModel);
    }

    else if (event is BreakHomeInitialization) {
      yield HomeNotInitialState();
    }

    else if (event is InitializeEditProfile) {
      EditProfileViewModel viewModel = await auth.getEditProfile();
      yield EditprofileInitiallied(viewModel);
    }

    else if (event is DoEditeProfile) {
      yield EditProfLoadingStart();
      bool result = await auth.postEditProfile(event.result);
      await Future.delayed(Duration(milliseconds: 500));
      yield EditProfLoadingFinish();
      if(result)
        yield ShowMessageState("موفق", "عملیات تصحیح مشخصات کاربری شما با موفقیت انجام شد");
    }

    else if (event is ShowMessage) {
      yield ShowMessageState(event.message, event.detail);
    }

    else if (event is DoChangePassword) {
      yield EditProfLoadingStart();
      bool result = await auth.changePass(oldPass: event.oldPassword, newPass: event.newPassword);
      await Future.delayed(Duration(milliseconds: 500));
      yield EditProfLoadingFinish();
      if(result)
        yield ShowMessageState("موفق", "عملیات تغییر رمز عبور شما با موفقیت انجام شد");
    }
  }
}