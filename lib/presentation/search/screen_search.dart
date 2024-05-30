import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_rv/application/search/search_bloc.dart';
import 'package:news_app_rv/core/common/dateformat.dart';
import 'package:news_app_rv/presentation/home/widgets/news_tile_widget.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CupertinoSearchTextField(
          autofocus: true,
          controller: searchController,
          padding: const EdgeInsets.all(15),
          suffixIcon: const Icon(Icons.clear),
          onSuffixTap: () {
            searchController.clear();
          },
          onSubmitted: (value) {
            log('search pressed');

            BlocProvider.of<SearchBloc>(context)
                .add(SearchNewsEvent(searchKey: searchController.text.trim()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SearchLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchSuccess) {
              return ListView.builder(
                itemCount: state.searchlist.articles?.length ?? 0,
                itemBuilder: (context, index) {
                  final date = CustomDateTimeFormatter.newsDateTimeFormat(
                      dateTime: state.searchlist.articles![index].publishedAt
                          .toString());

                  return NewsTileWidget(
                      size: size,
                      date: date,
                      newsList: state.searchlist.articles![index]);
                },
              );
            } else if (state is SearchFailure) {
              return Center(
                child: Text(state.showError),
              );
            }

            return const Center(child: Text('search news'));
          },
        ),
      ),
    );
  }
}
