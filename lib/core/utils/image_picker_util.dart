import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImagePickerUtil {
  ImagePickerUtil._();

  /// Get timestamp
  static String getOriginalName({required File file}) {
    final fileName = file.path.split('.').last;
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    return '$timeStamp.$fileName';
  }

  static Future<File> renameFile({required File file}) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath = path.join(
      dir,
      ImagePickerUtil.getOriginalName(file: file),
    );
    return await File(file.path).copy(newPath);
  }
}
