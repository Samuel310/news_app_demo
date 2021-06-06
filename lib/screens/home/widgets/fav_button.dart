import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  final Function onCLicked;
  final int pageNo;
  FavButton({required this.onCLicked, required this.pageNo});
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
            color: pageNo == 1 ? Colors.blue[900] : Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: pageNo == 1 ? Colors.white : Colors.red),
              SizedBox(width: 5),
              Text("Favs", style: TextStyle(color: pageNo == 1 ? Colors.white : Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
