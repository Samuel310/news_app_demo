import 'package:flutter/material.dart';
import 'package:news_app_demo/models/news_model.dart';
import 'package:news_app_demo/screens/home/widgets/fav_button.dart';
import 'package:news_app_demo/screens/home/widgets/fav_screen.dart';
import 'package:news_app_demo/screens/home/widgets/news_button.dart';
import 'package:news_app_demo/screens/home/widgets/news_screen.dart';

class HomeScreen extends StatefulWidget {
  final News news;
  HomeScreen({required this.news});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageViewController = PageController();
  List<int> favNews = [];
  int pageNo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageViewController,
              onPageChanged: (value) {
                setState(() {
                  pageNo = value;
                });
              },
              children: <Widget>[
                NewsScreen(news: this.widget.news, favNews: favNews),
                FavScreen(news: this.widget.news, favNews: favNews),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: NewsButton(
                  onCLicked: () {
                    setState(() {
                      pageViewController.animateToPage(0, duration: Duration(milliseconds: 400), curve: Curves.ease);
                    });
                  },
                  pageNo: pageNo,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: FavButton(
                  onCLicked: () {
                    setState(() {
                      pageViewController.animateToPage(1, duration: Duration(milliseconds: 400), curve: Curves.ease);
                    });
                  },
                  pageNo: pageNo,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
