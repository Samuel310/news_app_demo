import 'package:flutter/material.dart';
import 'package:news_app_demo/models/news_model.dart';
import 'package:news_app_demo/screens/home/home_screen.dart';
import 'package:news_app_demo/screens/home/widgets/session_expired.dart';
import 'package:news_app_demo/services/news_api.dart';

class HomeScreenWrapper extends StatelessWidget {
  static final routeName = "HomeScreenWrapper";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: NewsAppApiRepo().getNews(),
        builder: (BuildContext context, AsyncSnapshot<News> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: snapshot.error.toString() == "401"
                    ? SessionExpiredWidget()
                    : Center(
                        child: Text(snapshot.error.toString(), textAlign: TextAlign.center),
                      ),
              );
            } else {
              return HomeScreen(news: snapshot.requireData);
            }
          } else {
            return Container(
              child: Center(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(color: Colors.blue[900]),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
