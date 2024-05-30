
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_rv/application/favourites/favourites_bloc.dart';
import 'package:news_app_rv/core/common/dateformat.dart';
import 'package:news_app_rv/presentation/home/widgets/news_tile_widget.dart';

class ScreenFavourites extends StatelessWidget {
  const ScreenFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.transparent,
        title: const Text('Favourites'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoritesSuccess) {
              if (state.favlist.isEmpty) {
                return const Center(
                  child: Text('No news in favourites'),
                );
              }

              return ListView.builder(
                itemCount: state.favlist.length,
                itemBuilder: (context, index) {
                  final date = CustomDateTimeFormatter.newsDateTimeFormat(
                      dateTime: state.favlist[index].publishedAt.toString());

                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          NewsTileWidget(
                              size: size,
                              date: date,
                              newsList: state.favlist[index]),
                          CircleAvatar(
                            radius: 25,
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<FavouritesBloc>(context).add(
                                      RemoveFromFavourites(
                                          id: state.favlist[index].url!));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(8),
                                          content: Text(
                                              'news removed from favourites')));
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                          )
                        ],
                      ),
                    ],
                  );
                },
              );
            }

            return const Center(
              child: Text('No favs'),
            );
          },
        ),
      ),
    );
  }
}
