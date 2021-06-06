import 'package:dio/dio.dart';
import 'package:news_app_demo/constant.dart';

class AuthApiRepo {
  final Dio _dio = new Dio();

  AuthApiRepo() {
    _dio.options.baseUrl = AUTH_API_BASE_URL;
  }

  Future<String> signUp({required String email, required String username, required String password, required String cnfPassword}) async {
    try {
      Map data = {"email": email, "username": username, "password": password, "passwordConf": cnfPassword};
      final response = await _dio.post('/', data: data);
      print("::::::::::::: complete response ::::::::::::");
      print(response.data);
      if (response.statusCode == 200) {
        return response.data["Success"];
      } else {
        return response.data.toString();
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> signIn({required String email, required String password}) async {
    try {
      Map data = {"email": email, "password": password};
      final response = await _dio.post('/login', data: data);
      print("::::::::::::: complete response ::::::::::::");
      print(response.data);
      if (response.statusCode == 200) {
        return response.data["Success"];
      } else {
        return response.data.toString();
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
