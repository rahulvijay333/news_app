import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:news_app_rv/core/api_end_points.dart/api_end_point.dart';
import 'package:news_app_rv/domain/model/news_model.dart';
import 'package:news_app_rv/infrastructure/key/api_key.dart';

class HomeService {
  Future<(String?, NewsModel?)> getNewsFromHome(
      {required String category}) async {
    try {
      final Response response = await   Dio().get(
          ApiEndPoints.getNewHomeCategory,
          queryParameters: {'apiKey': apiKey, "category": category});

      if (response.statusCode == 200) {

        log('call success 200');
        return (null, NewsModel.fromMap(response.data));
      } else {
        return ('Error occured while connecting to server', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Check Internet connectivity', null);
        } else {
          return ('Try lator, server connection failed', null);
        }
      } else {
        return ("Error connection to server", null);
      }
    }
  }
}