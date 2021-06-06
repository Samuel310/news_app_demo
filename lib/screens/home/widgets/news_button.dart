import 'package:flutter/material.dart';

class NewsButton extends StatelessWidget {
  final Function onCLicked;
  final int pageNo;
  NewsButton({required this.onCLicked, required this.pageNo});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: InkWell(
        onTap: () {
          onCLicked();
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: pageNo == 0 ? Colors.blue[900] : Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.list, color: pageNo == 0 ? Colors.white : Colors.black),
              SizedBox(width: 5),
              Text("News", style: TextStyle(color: pageNo == 0 ? Colors.white : Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
