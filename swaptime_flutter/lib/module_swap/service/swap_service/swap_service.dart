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
    String uid = await _authService.userID;
    SwapModel swapModel = SwapModel(
        id: Uuid().v1(),
        swapperId: uid,
        ownerId: gameOwnerId,
        swapperGame: gameId);
    await _firestore
        .collection('swaps')
        .doc(gameOwnerId)
        .collection('requests')
        .add(swapModel.toJson());

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

  Future<List<SwapModel>> getSwapRequests() async {
    String uid = await _authService.userID;
    var response = await _firestore
        .collection('user_swaps')
        .doc(uid)
        .collection('requests')
        .get();

    List<SwapModel> swaps = [];
    response.docs.forEach((element) async {
      var swap = await _firestore
          .collection('swaps')
          .doc(element.data()['swap_id'])
          .get();
      swaps.add(SwapModel.fromJson(swap.data()));
    });
    return swaps;
  }
}
