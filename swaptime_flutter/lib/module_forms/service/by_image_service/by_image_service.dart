import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_upload/service/image_upload/image_upload_service.dart';

@provide
class ByImageService {
  final ImageUploadService _uploadService;
  ByImageService(this._uploadService);

  Future<String> upload(String filePath) {
    return _uploadService.uploadImage(filePath);
  }

  Future<dynamic> postProduct(dynamic productCreateRequest) {}
}
