import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_rv/domain/model/news_model.dart';
import 'package:news_app_rv/infrastructure/db/hive_db_service.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<GetAllFavorites>((event, emit) async {
      emit(FavoritesLoading());

      final favs = await HiveDB().getAllFavorites();

      emit(FavoritesSuccess(favlist: favs));
    });

    on<AddToFavourites>((event, emit) async {
      final status = await HiveDB().addToFav(news: event.news);

      if (status) {
        log('added succes to favs');
      } else {
        log('not added succes to favs');
      }
    });

    on<RemoveFromFavourites>((event, emit) async {
      final status = await HiveDB().removeFromFav(id: event.id);

      if (status) {
        log('delete success in bloc');

        final favs = await HiveDB().getAllFavorites();

        emit(FavoritesSuccess(favlist: favs));
      } else {
        log('delete no success b01');
      }
    });
  }
}
