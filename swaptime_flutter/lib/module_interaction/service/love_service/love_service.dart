import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';

@provide
class LoveService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;

  LoveService(this._authService);

  Future<bool> isGamesLoved(String gameId) async {
    String userId = await _authService.userID;
    String data = await _firestore
        .collection('user_interaction')
        .doc(userId)
        .collection('likes')
        .doc(gameId)
        .toString();
    if (data == null) {
      return false;
    }
    return jsonDecode(data)['loved'];
  }
}
