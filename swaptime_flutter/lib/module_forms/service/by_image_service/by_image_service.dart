import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_upload/service/image_upload/image_upload_service.dart';
import 'package:swaptime_flutter/utils/logger/logger.dart';

@provide
class ByImageService {
  String TAG = 'ByImageService';

  final ImageUploadService _uploadService;
  final Logger _logger;
  ByImageService(this._uploadService, this._logger);

  Future<String> upload(String filePath) {
    _logger.info(TAG, 'Uploading $filePath');
    return _uploadService.uploadImage(filePath);
  }

  Future<dynamic> postProduct(dynamic productCreateRequest) {}
}
