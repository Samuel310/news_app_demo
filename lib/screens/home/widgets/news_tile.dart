import 'package:flutter/material.dart';
import 'package:news_app_demo/models/news_model.dart';

class NewsListTile extends StatelessWidget {
  final Function onLikeBtnClicked;
  final NewsData newsData;
  NewsListTile({required this.onLikeBtnClicked, required this.newsData});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SizedBox(
                height: 50,
                width: 50,
                child: IconButton(
                  onPressed: () {
                    onLikeBtnClicked();
                  },
                  icon: newsData.isLiked ? Icon(Icons.favorite, color: Colors.red, size: 40) : Icon(Icons.favorite_outline, size: 40),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: Text(newsData.title, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold))),
                      ],
                    ),
                    Visibility(
                      visible: newsData.summary != null,
                      child: SizedBox(height: 10),
                    ),
                    Visibility(
                      visible: newsData.summary != null,
                      child: Row(
                        children: [
                          Expanded(child: Text(newsData.summary ?? "null", style: TextStyle(color: Colors.grey[700]))),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: Text(newsData.published, style: TextStyle(color: Colors.grey))),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
