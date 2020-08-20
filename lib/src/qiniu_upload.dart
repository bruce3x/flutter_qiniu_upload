import 'dart:io';

import 'package:flutter_qiniu_upload/src/api.dart';

class QiniuUpload extends QiniuFlutterApi {
  static final _hostApi = QiniuHostApi();

  static void install() {
    QiniuFlutterApi.setup(QiniuUpload());
  }

  static Future<void> upload(File file, String token, [String key]) async {
    final request = QiniuUploadRequest()
      ..file = file.path
      ..key = key
      ..token = token;
    final result = await _hostApi.upload(request);
    print('Task submit: $file ${result.requestId} $key');
  }

  @override
  void taskComplete(QiniuTaskComplete data) {
    // TODO
    print('Task completed: ${data.requestId} ${data.file.key} ${data.file.hash} ');
  }

  @override
  void taskUpdate(QiniuTaskUpdate data) {
    // TODO
    print('Task updated: ${data.requestId} ${data.percent}');
  }
}
