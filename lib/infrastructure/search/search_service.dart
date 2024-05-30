import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app_rv/core/api_end_points.dart/api_end_point.dart';
import 'package:news_app_rv/domain/model/news_model.dart';
import 'package:news_app_rv/infrastructure/key/api_key.dart';

class SearchService {
  Future<(String?, NewsModel?)> getNewsFromSearch(
      {required String searchKey}) async {
    try {
      final Response response = await Dio().get(
        '${ApiEndPoints.searchNews}q=$searchKey&apiKey=$apiKey',
      );
      
      if (response.statusCode == 200) {
      
        return (null, NewsModel.fromMap(response.data));
      } else {
        return ('Error occured while connecting to server', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Check Internet connectivity', null);
        } else {
          log(e.message.toString());
          return ('Try lator, server connection failed', null);
        }
      } else {
        return ("Error connection to server", null);
      }
    }
  }
}
