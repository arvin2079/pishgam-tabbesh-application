import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';


class ImageUtility {
  static final int _quality = 65;
  static final int _minWidth = 200;
  static final int _minHeight = 200;

  static Future<File> compressAndGetFile(File file) async {
    List<String> arr = file.path.split('/');
    arr.last = arr.last.split('.').first + '_modified.' + arr.last.split('.').last;
    String targetPath = arr.first;
    for(int i=1 ; i<arr.length ; i++) {
      targetPath += '/'+arr[i];
    }
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: _quality,
      minWidth: _minWidth,
      minHeight: _minHeight,
    );
    return result;
  }

  static Future<List<int>> compressAssetAndGetList(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      quality: _quality,
      minWidth: _minWidth,
      minHeight: _minHeight,
    );
    return list;
  }

}

// TODO : convert to base64