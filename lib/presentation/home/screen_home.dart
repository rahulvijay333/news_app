import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_rv/application/favourites/favourites_bloc.dart';

import 'package:news_app_rv/application/home/home_bloc.dart';
import 'package:news_app_rv/core/common/dateformat.dart';
import 'package:news_app_rv/presentation/favourites/screen_favs.dart';
import 'package:news_app_rv/presentation/home/widgets/news_tile_widget.dart';
import 'package:news_app_rv/presentation/search/screen_search.dart';

class ScreenMain extends StatelessWidget {
  final List<String> categoryList = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];

  ScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    BlocProvider.of<HomeBloc>(context)
        .add(GetNewCategoryWise(catergory: 'general'));

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              Text(
                'search',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis),
              )
            ],
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ScreenSearch();
              },
            ));
          },
        ),
        appBar: AppBar(
          title: const Text(
            'News App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<FavouritesBloc>(context)
                      .add(GetAllFavorites());
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ScreenFavourites();
                    },
                  ));
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.2),
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(5)),
                child: TabBar(
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    onTap: (index) {
                      BlocProvider.of<HomeBloc>(context).add(
                          GetNewCategoryWise(catergory: categoryList[index]));
                    },
                    isScrollable: true,
                    tabs: List.generate(
                        7,
                        (index) => Tab(
                              text: categoryList[index],
                            ))),
              ),
              const SizedBox(
                height: 10,
              ),
              //-----------------------------------------------------------home bloc implementation
              Expanded(
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is HomeSuccess) {
                      return ListView.builder(
                        cacheExtent: 200,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.newList.articles?.length ?? 0,
                        itemBuilder: (context, index) {
                          final date =
                              CustomDateTimeFormatter.newsDateTimeFormat(
                                  dateTime: state
                                      .newList.articles![index].publishedAt!
                                      .toString());

                          return NewsTileWidget(
                            size: size,
                            date: date,
                            newsList: state.newList.articles![index],
                          );
                        },
                      );
                    } else if (state is HomeFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.showError),
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<HomeBloc>(context).add(
                                      GetNewCategoryWise(catergory: 'general'));
                                },
                                child: const Text('Refresh'))
                          ],
                        ),
                      );
                    }

                    return const Center(
                      child: Text('News App'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
