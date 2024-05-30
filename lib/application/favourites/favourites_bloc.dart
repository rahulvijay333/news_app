import 'package:flutter_bloc/flutter_bloc.dart';
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
        add(GetAllFavorites());
      }
    });

    on<RemoveFromFavourites>((event, emit) async {
      final status = await HiveDB().removeFromFav(id: event.id);

      if (status) {
        add(GetAllFavorites());
      }
    });
  }
}
