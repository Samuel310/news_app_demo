import 'package:flutter/material.dart';
import 'package:news_app_demo/functions/logout.dart';
import 'package:news_app_demo/functions/session.dart';
import 'package:news_app_demo/models/news_model.dart';

import 'news_tile.dart';

class FavScreen extends StatefulWidget {
  final News news;
  final List<int> favNews;
  FavScreen({required this.news, required this.favNews});
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return this.widget.favNews.isEmpty
        ? Container(
            child: Center(
              child: Material(
                elevation: 10,
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Text("NO FAVS !", style: TextStyle(color: Colors.grey[600])),
                ),
              ),
            ),
          )
        : Scrollbar(
            child: ListView.builder(
              itemCount: this.widget.favNews.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: NewsListTile(
                    onLikeBtnClicked: () async {
                      if (await Session.isActive()) {
                        this.widget.news.data[this.widget.favNews[index]].isLiked = !this.widget.news.data[this.widget.favNews[index]].isLiked;
                        if (this.widget.news.data[this.widget.favNews[index]].isLiked) {
                          this.widget.favNews.add(index);
                        } else {
                          this.widget.favNews.removeAt(index);
                        }
                        setState(() {});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login again to continue..")));
                        await logoutUser(context);
                      }
                    },
                    newsData: this.widget.news.data[this.widget.favNews[index]],
                  ),
                );
              },
            ),
          );
  }
}
