import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';

@provide
class ReportService {
  final AuthService _authService;

  ReportService(this._authService);

  Future<void> reportGame(String gameId) async {
    var uid = await _authService.userID;

    await FirebaseFirestore.instance.collection('reports').doc('games').set({
      'game': gameId,
      'reporter': uid,
      'report_date': DateTime.now().toIso8601String()
    });
  }
}
