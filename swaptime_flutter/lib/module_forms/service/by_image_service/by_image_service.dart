import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/game_details/games_details.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_forms/manager/swap_item_repository/swap_item_repository.dart';
import 'package:swaptime_flutter/module_forms/request/item_create_request/item_create_request.dart';
import 'package:swaptime_flutter/module_upload/service/image_upload/image_upload_service.dart';
import 'package:swaptime_flutter/utils/logger/logger.dart';

@provide
class ByImageService {
  String TAG = 'ByImageService';

  final ImageUploadService _uploadService;
  final SwapItemManager _manager;
  final AuthService _authService;
  final Logger _logger;

  ByImageService(
    this._uploadService,
    this._logger,
    this._manager,
    this._authService,
  );

  Future<String> upload(String filePath) {
    _logger.info(TAG, 'Uploading $filePath');
    return _uploadService.uploadImage(filePath);
  }

  Future<GameDetailsResponse> postProduct(
    String title,
    String description,
    List<String> tags,
    String imageUrl,
  ) async {
    _logger.info(TAG, 'Creating New Item');
    var userId = await _authService.userID;
    return _manager.createItem(ItemCreateRequest(
      name: title,
      description: description,
      category: 'Games',
      tag: tags,
      mainImage: imageUrl,
      userID: userId,
    ));
  }
}
