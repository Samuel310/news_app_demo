import 'package:flutter/material.dart';
import 'package:news_app_demo/screens/auth/authentication_screen.dart';

class SessionExpiredWidget extends StatelessWidget {
  const SessionExpiredWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Session expired, Please login again to continue..", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue[100],
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, AuthenticationScreen.routeName, (route) => false);
          },
          child: Text("Login"),
        )
      ],
    );
  }
}
