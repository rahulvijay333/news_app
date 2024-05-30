part of 'favourites_bloc.dart';

class FavouritesEvent {}

class GetAllFavorites extends FavouritesEvent {}

class AddToFavourites extends FavouritesEvent {
  final Article news;

  AddToFavourites({required this.news});
}

class RemoveFromFavourites extends FavouritesEvent {
  final String id;

  RemoveFromFavourites({required this.id});
}
