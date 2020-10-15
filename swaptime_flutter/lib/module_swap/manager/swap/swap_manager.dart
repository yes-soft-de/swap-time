import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_swap/repository/swap_repository/swap_repository.dart';
import 'package:swaptime_flutter/module_swap/request/swap_request/swap_request.dart';
import 'package:swaptime_flutter/module_swap/response/swap_list/swap_list_response.dart';
import 'package:swaptime_flutter/module_swap/response/swap_response/swap_response.dart';

@provide
class SwapManager {
  final SwapRepository _swapRepository;
  SwapManager(this._swapRepository);

  Future<SwapListResponse> getMySwaps(String myId) =>
      _swapRepository.getMySwaps(myId);

  Future<CreateSwapResponse> createSwap(CreateSwapRequest createSwapRequest) =>
      _swapRepository.createSwap(createSwapRequest);
}
