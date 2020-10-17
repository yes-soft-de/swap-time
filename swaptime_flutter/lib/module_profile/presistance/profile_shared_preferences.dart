import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class ProfileSharedPreferencesHelper {
  Future<void> setUserName(String username) async {
    var prefsHelper = await SharedPreferences.getInstance();
    return prefsHelper.setString('profile_username', username);
  }

  Future<void> setUserLocation(String location) async {
    var prefsHelper = await SharedPreferences.getInstance();
    return prefsHelper.setString('profile_location', location);
  }

  Future<void> setUserImage(String image) async {
    var prefsHelper = await SharedPreferences.getInstance();
    return prefsHelper.setString('profile_image', image);
  }

  Future<void> setUserStory(String story) async {
    var prefsHelper = await SharedPreferences.getInstance();
    return prefsHelper.setString('profile_story', story);
  }

  Future<String> getUsername() async {
    var prefsHelper = await SharedPreferences.getInstance();
    return prefsHelper.getString('profile_username');
  }

  Future<String> getUserLocation() async {
    var prefsHelper = await SharedPreferences.getInstance();
    return prefsHelper.getString('profile_location');
  }

  Future<String> getUserStory() async {
    var prefsHelper = await SharedPreferences.getInstance();
    return prefsHelper.getString('profile_story');
  }

  Future<String> getImage() async {
    var prefsHelper = await SharedPreferences.getInstance();
    return prefsHelper.getString('profile_image');
  }
}
