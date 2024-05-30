
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_rv/application/favourites/favourites_bloc.dart';
import 'package:news_app_rv/core/common/dateformat.dart';
import 'package:news_app_rv/core/constants/const.dart';
import 'package:news_app_rv/domain/model/news_model.dart';
import 'package:news_app_rv/infrastructure/db/hive_db_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenDetails extends StatelessWidget {
  const ScreenDetails({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final date = CustomDateTimeFormatter.newsDateTimeFormat(
        dateTime: article.publishedAt!.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            space10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date ?? 'Date',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                    onTap: () {
                      //---------------------------------------------------------------add to favs
                      BlocProvider.of<FavouritesBloc>(context)
                          .add(AddToFavourites(news: article));
                    },
                    child: ValueListenableBuilder(
                      valueListenable: HiveDB().hiveBox.listenable(),
                      builder: (context, value, child) {
                        if (value.containsKey(article.url)) {
                          return Icon(
                            Icons.favorite,
                            color: Colors.red.shade900,
                          );
                        } else {
                          return const Icon(
                            Icons.favorite_outline,
                          );
                        }
                      },
                    ))
              ],
            ),
            space10,
            Text(
              article.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            space15,
            SizedBox(
              height: 250,
              child: article.urlToImage != null
                  ? Image.network(article.urlToImage, fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.deepPurple,
                        ),
                      );
                    }, errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/image_placeholder.png',
                        fit: BoxFit.cover,
                      );
                    })
                  : Image.asset(
                      'assets/image_placeholder.png',
                      fit: BoxFit.cover,
                    ),
            ),
            space10,
            Text(article.source!.name!),
            space10,
            article.description != null
                ? Text(
                    article.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20),
                  )
                : const SizedBox(),
            GestureDetector(
              onTap: () async {
                try {
                  final url = article.url;

                  if (await canLaunch(url!)) {
                    await launch(url);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Link not able to open via web brower')));
                  }
                }
              },
              child: Container(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '- view in web',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
            space15
          ],
        ),
      ),
    );
  }
}
