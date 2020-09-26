import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_swap/model/swap_model/swap_model.dart';
import 'package:uuid/uuid.dart';

@provide
class SwapService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;

  SwapService(this._authService);

  Future<SwapModel> createSwap(String gameOwnerId, String gameId) async {
    log('Creating a Swap!');
    String uid = await _authService.userID;
    SwapModel swapModel = SwapModel(
        id: Uuid().v1(),
        swapperId: uid,
        ownerId: gameOwnerId,
        swapperGame: gameId);
    await _firestore
        .collection('swaps')
        .doc(swapModel.id)
        .set(swapModel.toJson());

    await _firestore
        .collection('user_swaps')
        .doc(gameOwnerId)
        .collection('requests')
        .add({'swap_id': swapModel.id});
    await _firestore
        .collection('user_swaps')
        .doc(uid)
        .collection('requests')
        .add({'swap_id': swapModel.id});

    return swapModel;
  }

  Future<SwapModel> startSwap(SwapModel swapModel) async {
    swapModel.roomID = Uuid().v1();
    await _firestore
        .collection('swaps')
        .doc(swapModel.id)
        .set(swapModel.toJson());
    return swapModel;
  }

  Future<List<SwapModel>> getSwapRequests() async {
    String uid = await _authService.userID;
    var response = await _firestore
        .collection('user_swaps')
        .doc(uid)
        .collection('requests')
        .get();

    List<SwapModel> swaps = [];
    for (int i = 0; i < response.docs.length; i++) {
      var element = response.docs[i];
      var swap = await _firestore
          .collection('swaps')
          .doc(element.data()['swap_id'])
          .get();
      log(swap.id);
      swaps.add(SwapModel.fromJson(swap.data()));
    }
    log('Number of Swaps: ' + swaps.length.toString());
    return swaps;
  }

  Future<bool> isRequested(String gameId) async {
    log('Asking for $gameId if requested');
    String uid = await _authService.userID;
    var data = await _firestore
        .collection('user_swaps')
        .doc(uid)
        .collection('requests')
        .get();
    if (data.docs.isEmpty) {
      log('Docs are Empty, returning false');
      return false;
    }
    for (int i = 0; i < data.docs.length; i++) {
      var swapRef = data.docs[i];
      var swap = await _firestore.collection('swaps').doc(swapRef.id).get();
      if (!swap.exists) {
        log('No transaction found!, skipping a loop');
        continue;
      } else {
        SwapModel model = SwapModel.fromJson(swap.data());
        bool requested =
            (model.ownerGame == gameId || model.swapperGame == gameId);
        log('Game $gameId is Requested? ' + requested.toString());
        return requested;
      }
    }
    return false;
  }
}
