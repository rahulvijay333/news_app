import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_rv/domain/model/news_model.dart';

const dbFav = 'favouruites';

class HiveDB {
  static HiveDB instance = HiveDB._();

  factory HiveDB() {
    return instance;
  }

  HiveDB._();

  late final Box<Article> hiveBox;

  intialize() async {
    hiveBox = await Hive.openBox<Article>(dbFav);
    log(hiveBox.values.toList().toString());

    log('hive intilized');
  }

  Future<List<Article>> getAllFavorites() async {
    final favslist = hiveBox.values.toList();

    return favslist;
  }

  Future<bool> removeFromFav({required String id}) async {
    final newslists = hiveBox.values.toList();

    bool checkStatus = newslists.where((element) => element.url == id).isEmpty;

    if (!checkStatus) {
      await hiveBox.delete(id);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> addToFav({required Article news}) async {
    final newslists = hiveBox.values.toList();

    bool checkStatus =
        newslists.where((element) => element.url == news.url).isEmpty;

    if (checkStatus) {
      await hiveBox.put(news.url, news);

      return true;
    } else {
      await hiveBox.delete(news.url);

      return false;
    }
  }
}
