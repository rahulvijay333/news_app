import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_rv/domain/model/news_model.dart';
import 'package:news_app_rv/infrastructure/search/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService service;

  SearchBloc(this.service) : super(SearchInitial()) {
    on<SearchNewsEvent>((event, emit) async {

        log('search bloc called');
      emit(SearchLoading());

      final searchResult =
          await service.getNewsFromSearch(searchKey: event.searchKey);

      if (searchResult.$1 == null) {
        log('search success');
        emit(SearchSuccess(searchlist: searchResult.$2!));
      } else {
          log('search failed');
        emit(SearchFailure(showError: searchResult.$1!));
      }
    });
  }
}
