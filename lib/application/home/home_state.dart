part of 'home_bloc.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final NewsModel newList;

  HomeSuccess({required this.newList});
}

class HomeFailure extends HomeState {
  final String showError;

  HomeFailure({required this.showError});
}
