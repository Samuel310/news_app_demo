import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app_demo/screens/auth/authentication_screen.dart';
import 'package:news_app_demo/screens/home/home_screen_wraper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.brown));
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AuthenticationScreen.routeName,
      routes: {
        AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
        HomeScreenWrapper.routeName: (context) => HomeScreenWrapper(),
      },
    );
  }
}
