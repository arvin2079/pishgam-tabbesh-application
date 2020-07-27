import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pishgamv2/screens/homePage.dart';

import 'authClass.dart';

//home events
abstract class HomeEvent extends Equatable{
  const HomeEvent();
}

class InitializeHome extends HomeEvent {
  @override
  List<Object> get props => null;
}

//home states
abstract class HomeState extends Equatable{
  const HomeState();
}

class HomeInitiallized extends HomeState{
  const HomeInitiallized(this._viewModel);
  final HomeViewModel _viewModel;

  // ignore: non_constant_identifier_names
  HomeViewModel get ViewModel => _viewModel;

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
      yield HomeInitiallized(viewModel);
    }
  }
}