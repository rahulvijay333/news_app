part of 'search_bloc.dart';

class SearchEvent {}

class SearchNewsEvent extends SearchEvent {
  final String searchKey;

  SearchNewsEvent({required this.searchKey});
}
