import 'package:dio/dio.dart';
import 'package:news_app_demo/constant.dart';
import 'package:news_app_demo/functions/session.dart';
import 'package:news_app_demo/models/news_model.dart';

class NewsAppApiRepo {
  final Dio _dio = new Dio();

  NewsAppApiRepo() {
    _dio.options.baseUrl = NEWS_API_BASE_URL;
  }

  Future<News> getNews() async {
    try {
      if (await Session.isActive()) {
        final response = await _dio.get('/news');
        print("::::::::::::: complete response ::::::::::::");
        print(response.data);
        if (response.statusCode == 200) {
          return newsFromJson(response.data);
        } else {
          return Future.error(response.data);
        }
      } else {
        return Future.error("401");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
