import 'package:flutter/material.dart';
import 'package:news_app_demo/functions/logout.dart';
import 'package:news_app_demo/functions/session.dart';
import 'package:news_app_demo/models/news_model.dart';

import 'news_tile.dart';

class NewsScreen extends StatefulWidget {
  final News news;
  final List<int> favNews;
  NewsScreen({required this.news, required this.favNews});
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: this.widget.news.data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: NewsListTile(
              onLikeBtnClicked: () async {
                if (await Session.isActive()) {
                  this.widget.news.data[index].isLiked = !this.widget.news.data[index].isLiked;

                  if (this.widget.news.data[index].isLiked) {
                    this.widget.favNews.add(index);
                  } else {
                    this.widget.favNews.removeWhere((newsIndex) => newsIndex == index);
                  }
                  setState(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login again to continue..")));
                  await logoutUser(context);
                }
              },
              newsData: this.widget.news.data[index],
            ),
          );
        },
      ),
    );
  }
}
