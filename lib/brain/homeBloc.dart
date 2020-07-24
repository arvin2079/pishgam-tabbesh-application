import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'authClass.dart';

//home events
abstract class HomeEvent extends Equatable{
  const HomeEvent();
}

//home states
abstract class HomeState extends Equatable{
  const HomeState();
}



class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Auth auth = Auth();

  @override
  get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(event) async*{

  }
}