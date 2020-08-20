
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterQiniuUpload {
  static const MethodChannel _channel =
      const MethodChannel('flutter_qiniu_upload');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
