import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static setTimeOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime dt = DateTime.now().add(Duration(seconds: 7200));
    await prefs.setString('sessionTimeOut', dt.toString());
  }

  static Future<bool> isActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String timeOut = prefs.getString('sessionTimeOut') ?? '';
    if (timeOut.isNotEmpty) {
      DateTime validTimeLimit = DateTime.parse(timeOut);
      if (validTimeLimit.compareTo(DateTime.now()) > 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static deactivate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
