import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app_demo/functions/session.dart';
import 'package:news_app_demo/screens/auth/widgets/signin_widget.dart';
import 'package:news_app_demo/screens/auth/widgets/signup_widget.dart';
import 'package:news_app_demo/screens/home/home_screen_wraper.dart';

class AuthenticationScreen extends StatefulWidget {
  static final routeName = "AuthenticationScreen";
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool showSignUpScreen = true;
  bool isScreenLoading = true;

  @override
  void initState() {
    checkSessionValidity();
    super.initState();
  }

  void checkSessionValidity() async {
    if (await Session.isActive()) {
      Navigator.pushNamedAndRemoveUntil(context, HomeScreenWrapper.routeName, (route) => false);
    } else {
      setState(() {
        isScreenLoading = false;
      });
    }
  }

  void changeView() {
    setState(() {
      showSignUpScreen = !showSignUpScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isScreenLoading
          ? Container(
              child: Center(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(color: Colors.blue[900]),
                ),
              ),
            )
          : Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 30,
                  child: Text("Welcome !!", style: TextStyle(color: Colors.white, fontSize: 35)),
                ),
                showSignUpScreen ? SignUpWidget(changeView: changeView) : SignInWidget(changeView: changeView),
              ],
            ),
    );
  }
}
