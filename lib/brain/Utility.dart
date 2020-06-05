import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';


class Utility {

  static Future<File> compressAndGetFile(File file) async {
    List<String> arr = file.path.split('/');
    arr.last = arr.last.split('.').first + '_modified.' + arr.last.split('.').last;
    String targetPath = '';
    for(String s in arr) {
      targetPath += s;
    }
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 80,
      minWidth: 200,
      minHeight: 200
    );
    return result;
  }

  static Future<List<int>> compressAssetAndGetList(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 200,
      minWidth: 200,
      quality: 10,
      rotate: 180,
    );
    return list;
  }

}