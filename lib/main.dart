import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_rv/application/favourites/favourites_bloc.dart';
import 'package:news_app_rv/application/home/home_bloc.dart';
import 'package:news_app_rv/application/search/search_bloc.dart';
import 'package:news_app_rv/domain/model/news_model.dart';
import 'package:news_app_rv/infrastructure/db/hive_db_service.dart';
import 'package:news_app_rv/infrastructure/home/home_service.dart';
import 'package:news_app_rv/infrastructure/search/search_service.dart';
import 'package:news_app_rv/presentation/splash/screen_splash.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HiveDB().intialize();

  if (!Hive.isAdapterRegistered(ArticleAdapter().typeId)) {
    Hive.registerAdapter(ArticleAdapter());
  }

  if (!Hive.isAdapterRegistered(SourceAdapter().typeId)) {
    Hive.registerAdapter(SourceAdapter());
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final HomeService homeService = HomeService();
  final SearchService searchService = SearchService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(homeService),
        ),
        BlocProvider(
          create: (context) => SearchBloc(searchService),
        ),
        BlocProvider(
          create: (context) => FavouritesBloc(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenSplash(),
      ),
    );
  }
}
