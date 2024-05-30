import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_rv/domain/model/news_model.dart';
import 'package:news_app_rv/infrastructure/search/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService service;

  SearchBloc(this.service) : super(SearchInitial()) {
    on<SearchNewsEvent>((event, emit) async {
      emit(SearchLoading());

      final searchResult =
          await service.getNewsFromSearch(searchKey: event.searchKey);

      if (searchResult.$1 == null) {
        emit(SearchSuccess(searchlist: searchResult.$2!));
      } else {
        emit(SearchFailure(showError: searchResult.$1!));
      }
    });
  }
}
