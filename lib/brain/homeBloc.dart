import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pishgamv2/screens/homePage.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';

import 'authClass.dart';

//home events
abstract class HomeEvent extends Equatable{
  const HomeEvent();
}

class InitializeHome extends HomeEvent {
  @override
  List<Object> get props => null;
}

class InitializeMyLesson extends HomeEvent {
  @override
  List<Object> get props => null;
}

//home states
abstract class HomeState extends Equatable{
  const HomeState();
}

class HomeInitiallized extends HomeState{
  const HomeInitiallized(this.viewModel);
  final HomeViewModel viewModel;

  @override
  List<Object> get props => null;
}

class MyLessonsInitiallized extends HomeState {
  MyLessonsInitiallized(this.viewModel);
  final MyLessonsViewModel viewModel;

  @override
  List<Object> get props => null;
}



class HomeNotInitialState extends HomeState {
  @override
  List<Object> get props => null;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Auth auth = Auth();

  @override
  get initialState => HomeNotInitialState();

  @override
  Stream<HomeState> mapEventToState(event) async*{
    if(event is InitializeHome) {
      HomeViewModel viewModel = await auth.initializeHome();
      print('hererererr');
      yield HomeInitiallized(viewModel);
    }

    else if(event is InitializeMyLesson) {
      MyLessonsViewModel viewModel = await auth.initializeMyLesson();
      yield MyLessonsInitiallized(viewModel);
    }
  }
}