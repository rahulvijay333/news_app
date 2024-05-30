part of 'home_bloc.dart';

class HomeEvent {}

class GetNewCategoryWise extends HomeEvent {
  final String catergory;

  GetNewCategoryWise({required this.catergory});
}
