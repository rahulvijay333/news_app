part of 'favourites_bloc.dart';

class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class FavoritesLoading extends FavouritesState {}

class FavoritesSuccess extends FavouritesState {
  final List<Article> favlist;

  FavoritesSuccess({required this.favlist});
}

class FavoritesFailed extends FavouritesState {
  final String showError;

  FavoritesFailed({required this.showError});
}
