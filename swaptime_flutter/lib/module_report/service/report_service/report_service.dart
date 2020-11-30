import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';

@provide
class ReportService {
  final AuthService _authService;
  ReportService(this._authService);

  Future<void> reportGame(String gameId) async {
    var uid = await _authService.userID;
    await _setReported(gameId);

    await FirebaseFirestore.instance.collection('reports').doc('games').set({
      'game': gameId,
      'reporter': uid,
      'report_date': DateTime.now().toIso8601String()
    });
  }

  Future<void> _setReported(String gameId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> reportedList = await preferences.getStringList('reported');
    if (reportedList == null) {
      await preferences.setStringList('reported', [gameId]);
      return;
    }
    reportedList.add(gameId);
    await preferences.setStringList('reported', reportedList);
    return;
  }

  Future<bool> isReported(String gameId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> reportedList = await preferences.getStringList('reported');
    if (reportedList == null) {
      return false;
    }
    if (reportedList.contains(gameId)) {
      return true;
    }
    return false;
  }
}
