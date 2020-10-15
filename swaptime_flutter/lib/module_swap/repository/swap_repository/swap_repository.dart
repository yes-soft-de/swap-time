import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';
import 'package:swaptime_flutter/module_swap/request/swap_request/swap_request.dart';
import 'package:swaptime_flutter/module_swap/response/swap_list/swap_list_response.dart';
import 'package:swaptime_flutter/module_swap/response/swap_response/swap_response.dart';

@provide
class SwapRepository {
  final ApiClient _client;
  SwapRepository(this._client);

  Future<SwapListResponse> getMySwaps(String userID) async {
    var response = await _client.get(Urls.API_SWAP_BY_ME + '/$userID');

    return response == null ? null : SwapListResponse.fromJson(response);
  }

  Future<CreateSwapResponse> createSwap(
      CreateSwapRequest createSwapRequest) async {
    Map<String, dynamic> result =
        await _client.post(Urls.API_CREATE_SWAP, createSwapRequest.toJson());

    return result != null ? CreateSwapResponse.fromJson(result) : null;
  }
}
