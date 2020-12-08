import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ImageCacher {
  static Future<String> cachImage(String url) async {
    print('Saving ' + url);
    // Generate a save path
    var tempDir = await getTemporaryDirectory();
    var savePath = tempDir.path + '/' + Uuid().v1();

    print('Saving into: ' + savePath);
    // Download the image
    var client = Dio();
    var response = await client.get(
      url,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );

    // Open stream to save the image
    print('Writing the file');
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);

    // Write the downloaded image
    raf.writeFromSync(response.data);
    await raf.close();

    // Return what we wanted from all this
    print('Final Path: ' + savePath);
    return savePath;
  }
}
