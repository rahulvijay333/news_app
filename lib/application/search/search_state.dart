part of 'search_bloc.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final NewsModel searchlist;

  SearchSuccess({required this.searchlist});
}

class SearchFailure extends SearchState {
  final String showError;

  SearchFailure({required this.showError});
}
