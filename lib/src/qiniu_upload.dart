import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter_qiniu_upload/flutter_qiniu_upload.dart';
import 'package:flutter_qiniu_upload/src/api.dart';
import 'package:flutter_qiniu_upload/src/exception.dart';

class QiniuUpload extends QiniuFlutterApi {
  static final _hostApi = QiniuHostApi();

  static final _completerMap = HashMap<String, Completer<QiniuFile>>();
  static final _progressMap = HashMap<String, StreamController<QiniuProgress>>();

  static void initialize() {
    QiniuFlutterApi.setup(QiniuUpload());
  }

  /// return the uploaded file info from qiniu.
  static Future<QiniuFile> uploadDirectly(File file, String token, [String key]) async {
    final request = QiniuUploadRequest()
      ..file = file.path
      ..key = key
      ..token = token;
    final completer = Completer<QiniuFile>();
    final result = await _hostApi.upload(request);
    _completerMap[result.requestId] = completer;

    final QiniuFile data = await completer.future;
    return data;
  }

  ///  return the request id which can be used to query progress or cancel uploading.
  static Future<String> upload(File file, String token, [String key]) async {
    final request = QiniuUploadRequest()
      ..file = file.path
      ..key = key
      ..token = token;
    // ignore: close_sinks
    final controller = StreamController<QiniuProgress>();
    final result = await _hostApi.upload(request);
    _progressMap[result.requestId] = controller;

    return result.requestId;
  }

  static Stream<QiniuProgress> progress(String requestId) {
    return _progressMap[requestId].stream;
  }

  static Future<void> cancel(String requestId) async {
    await _hostApi.cancel(QiniuUploadResult()..requestId = requestId);
  }

  @override
  void taskComplete(QiniuTaskComplete data) {
    final file = QiniuFile(data.hash, data.key);
    final completer = _completerMap[data.requestId];
    if (completer != null) {
      completer.complete(file);
    }
    final controller = _progressMap[data.requestId];
    if (controller != null) {
      controller.add(QiniuProgress.complete(file));
      controller.close();
    }
  }

  @override
  void taskUpdate(QiniuTaskUpdate data) {
    // ignore: close_sinks
    final controller = _progressMap[data.requestId];
    if (controller != null) {
      controller.add(QiniuProgress.progress(data.percent));
    }
  }

  @override
  void taskCancelled(QiniuTaskCancellation data) {
    final error = UploadCancellation();
    final completer = _completerMap[data.requestId];
    if (completer != null) {
      completer.completeError(error);
    }
    final controller = _progressMap[data.requestId];
    if (controller != null) {
      controller.addError(error);
      controller.close();
    }
  }

  @override
  void taskError(QiniuTaskError data) {
    final error = UploadException(data.error, data.statusCode);
    final completer = _completerMap[data.requestId];
    if (completer != null) {
      completer.completeError(error);
    }
    final controller = _progressMap[data.requestId];
    if (controller != null) {
      controller.addError(error);
      controller.close();
    }
  }
}
