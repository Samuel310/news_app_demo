import 'package:flutter/cupertino.dart';
import 'package:news_app_demo/functions/session.dart';
import 'package:news_app_demo/screens/auth/authentication_screen.dart';

Future<void> logoutUser(BuildContext context) async {
  await Session.deactivate();
  Navigator.pushNamedAndRemoveUntil(context, AuthenticationScreen.routeName, (route) => false);
}
