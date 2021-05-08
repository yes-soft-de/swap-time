import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class NotificationPrefs {
  Future<void> saveNotification(String notificationToken) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setString('NotificationToken', notificationToken);
  }

  Future<String> getNotification() async {
    var preferences = await SharedPreferences.getInstance();
    return preferences.getString('NotificationToken');
  }
}
